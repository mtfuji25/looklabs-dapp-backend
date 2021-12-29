// Level import
import { Level } from "../Core/Level";

// Constants
import { MAIN_BG_COLOR } from "../Constants/Constants";

// Layers imports
import { MapLayer } from "../Layers/Lobby/Map";
import { PlayerLayer } from "../Layers/Lobby/Player";
import { ViewContext, ViewLayer } from "../Layers/Lobby/View";
import { BattleStatusLayer } from "../Layers/Lobby/Status";
import { LogsLayer } from "../Layers/Lobby/Log";
import { GameStatus, Listener, msgTypes, ServerMsg } from "../Clients/Interfaces";
import { ResultsLevel } from "./Results";
import { OverlayMap } from "../Layers/Lobby/Overlays";

interface LobbyLevelContext extends ViewContext {
    // View properties
    zoom: number;
    offsetX: number;
    offsetY: number;
}

class LobbyLevel extends Level {

    private gameStatusListener: Listener;
    private connectionListener: Listener;

    private levelContext: LobbyLevelContext = {
        // View properties
        zoom: 0.0,
        offsetX: 0.0,
        offsetY: 0.0
    };

    onStart(): void {

        // Add listeners
        this.gameStatusListener = this.context.ws.addListener(
            "game-status",
            (msg) => this.onGameStatusMessage(msg)
        );

        this.connectionListener = this.context.ws.addListener(
            "connection",
            (event) => this.onConnectionEvent(event)
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

        // Pushs the player controller
        this.layerStack.pushLayer(
            new PlayerLayer(
                this.ecs,
                this.levelContext,
                this.context.app,
                this.context.ws,
                this.context.strapi,
                this.context.res,
            )
        );

        // Load all overlays
        this.layerStack.pushLayer(
            new OverlayMap(
                this.ecs,
                this.levelContext,
                this.context.app,
                this.context.res
            )
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
    }

    async onUpdate(deltaTime: number) {}

    onClose(): void {
        this.layerStack.destroy();

        this.connectionListener.destroy();
        this.gameStatusListener.destroy();
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
}

export { LobbyLevel, LobbyLevelContext };
