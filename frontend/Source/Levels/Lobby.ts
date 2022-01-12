// Level import
import { Level } from "../Core/Level";

import { v4 as uuidv4 } from "uuid";

// Constants
import { MAIN_BG_COLOR } from "../Constants/Constants";

// Layers imports
import { MapLayer } from "../Layers/Lobby/Map";
import { PlayerLayer } from "../Layers/Lobby/Player";
import { ViewContext, ViewLayer } from "../Layers/Lobby/View";
import { BattleStatusLayer } from "../Layers/Lobby/Status";
import { LogsLayer } from "../Layers/Lobby/Log";
import { GameState, GameStatus, Listener, msgTypes, ServerMsg } from "../Clients/Interfaces";
import { ResultsLevel } from "./Results";
import { OverlayMap } from "../Layers/Lobby/Overlays";
import { IntroSequence } from "../Layers/Lobby/IntroSequence";

interface LobbyLevelContext extends ViewContext {
    // View properties
    zoom: number;
    offsetX: number;
    offsetY: number;
}


export enum GameStateValues {
    SPAWN,
    COUNTDOWN3,
    COUNTDOWN2,
    COUNTDOWN1,
    COUNTDOWN0,
    FIGHT
}

class LobbyLevel extends Level {

    private gameStatusListener: Listener;
    private connectionListener: Listener;
    private gameStateListener: Listener;

    private levelContext: LobbyLevelContext = {
        // View properties
        zoom: 0.0,
        offsetX: 0.0,
        offsetY: 0.0
    };

    private introSequence:IntroSequence;

    async onStart(): Promise<void> {

        // Add listeners
        this.gameStatusListener = this.context.ws.addListener(
            "game-status",
            (msg) => this.onGameStatusMessage(msg)
        );

        this.connectionListener = this.context.ws.addListener(
            "connection",
            (event) => this.onConnectionEvent(event)
        );

        this.gameStateListener = this.context.ws.addListener(
            "game-state",
            (msg) => this.onGameStateMessage(msg)
        );

        // Sets bg color of main app
        this.context.app.renderer.backgroundColor = MAIN_BG_COLOR;

        // Pushs view controller
        this.layerStack.pushLayer(
            new ViewLayer(this.ecs, this.levelContext, this.context.app, this.context.inputs)
        );

        // Pushs map generator
        this.layerStack.pushLayer(
            new MapLayer(
                this.ecs,
                this.levelContext,
                this.context.app,
                this.context.res
            )
        );
        
       const playerLayer = new PlayerLayer(
            this.ecs,
            this.levelContext,
            this.context.app,
            this.context.ws,
            this.context.strapi,
            this.context.res,
        );
        // Pushs the player controller
        this.layerStack.pushLayer(
            playerLayer
        );
        
        const overlayLayer = new OverlayMap(
            this.ecs,
            this.levelContext,
            this.context.app,
            this.context.res
        );
        // Load all overlays
        this.layerStack.pushLayer(
            overlayLayer
        );

        this.layerStack.pushOverlay(
            new BattleStatusLayer(
                this.ecs,
                this.context.app,
                this.context
            )
        );

        this.layerStack.pushOverlay(
            new LogsLayer(
                this.ecs,
                this.context.app,
                this.context
            )
        );
        
        await this.context.ws.whenReady();

        const response = await this.context.ws.request(
            {
                uuid: uuidv4(),
                type: "request",
                content: {
                    type: "game-state"
                }
            }
        );    

        const content = response.content as GameState;
        // if we're showing the intro, create intro sequence
        // create intro sequence controller
        this.introSequence = new IntroSequence(this.context.app, playerLayer, overlayLayer,this.context.res);
        this.introSequence.updateIntroState(content.gameState);
        
        
    }

    async onUpdate(deltaTime: number) {
        if (this.introSequence) {
            this.introSequence.onUpdate(deltaTime);
        }
    }

    onClose(): void {
        this.connectionListener.destroy();
        this.gameStatusListener.destroy();
        this.gameStateListener.destroy();
        if (this.introSequence) {
            this.introSequence.destroy();
        }
    }

    // Handles all game-status messages from backend
    onGameStatusMessage(msg: ServerMsg) {
        let content: GameStatus;

        // Check the veracity of message type
        if (msg.content.msgType == msgTypes.gameStatus) {

            // Perfom the cast to corret msg type
            content = msg.content as GameStatus;

            // Checks for the interest type of message
            if (content.gameStatus == "awaiting") {

                this.context.engine.loadLevel(new ResultsLevel(
                    this.context,
                    "Results",
                    {
                        gameId: content.gameId,
                    }
                ));
            }
        }

        // Doesn't handles the event, allow event propagation
        // in the event listeners queue
        return false;
    }

    // Handles all connection events with backend
    onConnectionEvent(event: Event) {
        
        this.context.engine.loadLevel(
            new LobbyLevel(
                this.context, "Lobby",
                {
                    gameId: this.props.gameId,
                    playerNames: this.props.playerNames
                }
            )
        );

        // Handles the event, doesn't allow event propagation
        // in the event listeners queue
        return true;
    }

    onGameStateMessage (msg:ServerMsg) {
        let content: GameState;

        // Check the veracity of message type
        if (msg.content.msgType == msgTypes.gameState) {

            // Perfom the cast to corret msg type
            if (this.introSequence) {
                content = msg.content as GameState;
               
                this.introSequence.updateIntroState(content.gameState);
            }
        }
        return false;
    }
}

export { LobbyLevel, LobbyLevelContext };
