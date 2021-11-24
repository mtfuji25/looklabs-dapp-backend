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
import { GameStatus, ServerMsg } from "../Clients/Interfaces";
import { ResultsLevel } from "./Results";

interface LobbyLevelContext extends ViewContext {
    // View properties
    zoom: number;
    offsetX: number;
    offsetY: number;
}

class LobbyLevel extends Level {

    private levelContext: LobbyLevelContext = {
        // View properties
        zoom: 0.0,
        offsetX: 0.0,
        offsetY: 0.0
    };

    onStart(): void {

        this.context.ws.addListener("game-status", (msg) => this.onStatus(msg));

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

    onUpdate(deltaTime: number) {}

    onClose(): void {
        this.layerStack.destroy();
    }

    onStatus(status: ServerMsg) {

        status.content = status.content as GameStatus;

        if (status.content.gameStatus == "awaiting") {
            this.context.engine.loadLevel(new ResultsLevel(
                this.context, "Results",
                {
                    gameId: status.content.gameId
                }
            ));
        }

        return true;
    }
}

export { LobbyLevel, LobbyLevelContext };