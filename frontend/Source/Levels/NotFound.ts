import { Level } from "../Core/Level";

// Layers imports
import { TextLayer } from "../Layers/NotFound/Text";
import { MapLayer } from "../Layers/NotFound/Basemap";

// Web Clients imports

// Await level bg color
const BLACK_BG_COLOR = 0x000;

class NotFoundLevel extends Level {

    private listenerId: number;

    onStart(): void {
        // Sets bg color of main app
        this.context.app.renderer.backgroundColor = BLACK_BG_COLOR;

        this.connectLayers();
    }

    connectLayers(): void {
        this.layerStack.pushLayer(new MapLayer(
            this.ecs,
            this.context.app,
            this.context.res
        ));
        this.layerStack.pushLayer(new TextLayer(
            this.ecs,
            this.context.app,
            this.context
        ));
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {
        this.context.ws.remMsgListener(this.listenerId);
    }
};

export { NotFoundLevel };