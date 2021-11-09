import { Level } from "../core/level";
import { PlayerLayer } from "../layers/player";
import { MapLayer } from "../layers/map";

class DefaultLevel extends Level {

    onStart(): void {
        this.layerStack.pushLayer(new MapLayer(
            this.ecs, this.context.app, this.context.resources
        ));
        this.layerStack.pushLayer(new PlayerLayer(
            this.ecs, this.context.app, this.context.wsClient, this.context.resources
        ));
    }

    onUpdate(deltaTime: number) {
        
    }

    onClose(): void {}
};

export { DefaultLevel };