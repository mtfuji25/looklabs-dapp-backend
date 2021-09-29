import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";

const BG_RES_NAME = "bg-";

class BgLayer {
    constructor(app) {
        this.app = app;
        this.layers = [];
        this.number = 6;
        this.texWidth = 1920;
        this.texHeight = 1080;
        this.parallax = 1.0;
        this.currentX = 0.0;
    }

    onAttach() {
        for (let i = this.number; i > 0; --i) {
            let entity = ECS.createEntity(0, 0);
            let sprite = ECS.addComponent(entity, ECS.TILISPRITE);
            sprite.setImg(this.app.loader.resources[BG_RES_NAME + i]);
            sprite.sprite.width = this.texWidth;
            sprite.sprite.height = this.texHeight;
            
            sprite.addStage(this.app);
            this.layers.push(entity);
        }
    }

    onUpdate(deltaTime) {
        if (inputs.key[KEYS.A])
            this.currentX += this.parallax;
        if (inputs.key[KEYS.D])
            this.currentX -= this.parallax;

        this.layers.forEach((layer, i) => {
            let sprite = ECS.getComponent(layer, ECS.TILISPRITE);
            sprite.sprite.tilePosition.x = (this.currentX / (this.number - i));
        });
    }
}

export { BgLayer };