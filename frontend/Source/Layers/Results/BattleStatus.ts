import { Layer } from "../../Core/Layer";
import { ECS } from "../../Core/Ecs/Core/Ecs";

import { Application } from "pixi.js";
import { Sprite } from "../../Core/Ecs/Components/Sprite";

class BattleStatusLayer extends Layer {
    private app: Application;
    private title: Sprite;
    private button: Sprite;

    constructor(ecs: ECS, app: Application) {
        super("TesteLayer", ecs);

        this.app = app;

        // Create two sprites
        this.title = this.ecs.createEntity().addSprite();
        this.button = this.ecs.createEntity().addSprite();

        // Anchor it in 0,0
        this.title.sprite.anchor.set(0.0);
        this.button.sprite.anchor.set(0.0);

        // Set sprite image
        this.title.setImg(this.app.loader.resources["thePitSmall"]);
        this.button.setImg(this.app.loader.resources["battleEnded"]);

        // Add it to stage
        this.title.addStage(this.app);
        this.button.addStage(this.app);
    }

    onAttach() {
        this.title.setPos(30, 30);
        this.button.setPos(30, 83);
    }

    onUpdate(deltaTime: number) {}

    onDetach() {
        this.self.destroy();
    }
}

export { BattleStatusLayer };