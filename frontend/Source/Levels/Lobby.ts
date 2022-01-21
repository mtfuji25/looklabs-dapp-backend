// Level import
import { Level } from "../Core/Level";

import { v4 as uuidv4 } from "uuid";

// Constants
import { MAIN_BG_COLOR } from "../Constants/Constants";

// Layers imports
import { MapLayer } from "../Layers/Lobby/Map";
import { Player, PlayerLayer } from "../Layers/Lobby/Player";
import { ViewContext, ViewLayer } from "../Layers/Lobby/View";
import { BattleStatusLayer } from "../Layers/Lobby/Status";
import { LogsLayer } from "../Layers/Lobby/Log";
import { GameState, GameStatus, Listener, msgTypes, RemainPlayersListener, RemainPlayersMsg, ServerMsg } from "../Clients/Interfaces";
import { ResultsLevel } from "./Results";
import { OverlayMap } from "../Layers/Lobby/Overlays";
import { IntroSequence } from "../Layers/Lobby/IntroSequence";
import { Fatina } from "fatina/build/code/fatina";

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
    private remainPlayerlistener: RemainPlayersListener;

    private remaining: number = 0;
    private showDownStart: boolean = false;

    private levelContext: LobbyLevelContext = {
        // View properties
        zoom: 0.0,
        offsetX: 0.0,
        offsetY: 0.0
    };

    private introSequence:IntroSequence;
    private tweenEngine:Fatina;
    private playerLayer:PlayerLayer;

    async onStart(): Promise<void> {

        this.tweenEngine = new Fatina();
        this.tweenEngine.init();

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

        this.remainPlayerlistener = this.context.ws.addListener(
            "remain-players", 
            msg => this.onRemainPlayersMsg(msg)
        );

        // Sets bg color of main app
        this.context.app.renderer.backgroundColor = MAIN_BG_COLOR;

        const viewLayer = new ViewLayer(this.ecs, this.levelContext, this.context.app, this.context.inputs);
        // Pushs view controller
        this.layerStack.pushLayer(
            viewLayer
        );

        const mapLayer = new MapLayer(
            this.ecs,
            this.levelContext,
            this.context.app,
            this.context.res
        );
        // Pushs map generator
        this.layerStack.pushLayer(
            mapLayer
        );
        
      this.playerLayer = new PlayerLayer(
            this.ecs,
            this.levelContext,
            this.context.app,
            this.context.ws,
            this.context.strapi,
            this.context.res,
        );
        // Pushs the player controller
        this.layerStack.pushLayer(
            this.playerLayer
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

        const statusLayer = new BattleStatusLayer(
            this.ecs,
            this.context.app,
            this.context
        );

        this.layerStack.pushOverlay(
            statusLayer
        );

        const logsLayer = new LogsLayer(
            this.ecs,
            this.context.app,
            this.context
        );
        this.layerStack.pushOverlay(
          logsLayer  
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
        // create intro sequence controller
        this.introSequence = new IntroSequence(this.context.app, this.playerLayer, overlayLayer, viewLayer, this.context.res);
        this.introSequence.updateIntroState(content.gameState);
        if (content.gameState == "fight")
            this.playBackgroundMusic(Level.LOBBY_SOUND);
        
    }

    async onUpdate(deltaTime: number) {
        if (this.introSequence) {
            this.introSequence.onUpdate(deltaTime);
        }

        if (this.remaining == 1) {
            this.playerLayer.celebrate(this.tweenEngine);
        }

        if (this.remaining > 0 &&  this.remaining <= 2 && !this.showDownStart) {
            this.showDownStart = true;
            // switch BG music to showdown
            this.playBackgroundMusic(Level.SHOWDOWN_SOUND);
        }
    }

    onClose(): void {
        this.connectionListener.destroy();
        this.gameStatusListener.destroy();
        this.gameStateListener.destroy();
        this.remainPlayerlistener.destroy();
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
                if (content.gameState == "fight")
                    this.playBackgroundMusic(Level.LOBBY_SOUND);
                this.introSequence.updateIntroState(content.gameState);
            }
        }
        return false;
    }

    onRemainPlayersMsg(msg: ServerMsg) {
        const { remainingPlayers } = msg.content as RemainPlayersMsg;
       this.remaining = remainingPlayers;
        return false;
    }
}

export { LobbyLevel, LobbyLevelContext };
