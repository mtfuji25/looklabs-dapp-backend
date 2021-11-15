// Level import
import { Level } from "../Core/Level";

// Layers imports
import { MapLayer } from "../Layers/Lobby/Map";
import { PlayerLayer } from "../Layers/Lobby/Player";
import { ViewContext, ViewLayer } from "../Layers/Lobby/View";

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
        // Pushs view controller
        this.layerStack.pushLayer(
            new ViewLayer(this.ecs, this.levelContext, this.context.inputs)
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
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
}

export { LobbyLevel, LobbyLevelContext };