import { Level } from "../Core/Level";

// Layers imports
import { TextLayer } from "../Layers/Await/Text";
import { MapLayer } from "../Layers/Await/Basemap";

const BLACK_BG_COLOR = 0x000;

class AwaitingLevel extends Level {

    onStart(): void {

        this.context.ws.request({
            type: "game-id"
        }).then((response) => {
            this.connectLayers(response.content.gameId);
        }).catch((err) => {
            console.log(err);
            this.context.close = true;
        });

        // Sets bg color of main app
        this.context.app.renderer.backgroundColor = BLACK_BG_COLOR;
    }

    connectLayers(gameId: number): void {
        this.layerStack.pushLayer(new MapLayer(
            this.ecs,
            this.context.app,
            this.context.res
        ));

        this.context.strapi.getGameById(gameId)
        .then((currentGame) => {
            this.layerStack.pushLayer(new TextLayer(
                this.ecs,
                this.context.app,
                this.context,
                currentGame
            ));
        });
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
};

export { AwaitingLevel };