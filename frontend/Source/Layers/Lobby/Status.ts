import { Layer } from "../../Core/Layer";
import { ECS } from "../../Core/Ecs/Core/Ecs";

import { Application, ITextStyle } from "pixi.js";
import { Sprite } from "../../Core/Ecs/Components/Sprite";
import { Text } from "../../Core/Ecs/Components/Text";

class BattleStatusLayer extends Layer {
    private app: Application;
    private title: Sprite;
    private card: Sprite;
    private timeLeft: Text;
    private playersLeft: Text;

    private readonly textStyle: Partial<ITextStyle> = {
        fontFamily: "monospace",
        fontWeight: "700",
        fontSize: "16px",
        lineHeight: 23.7,
        fill: "#000000"
    }

    constructor(ecs: ECS, app: Application) {
        super("TesteLayer", ecs);

        this.app = app;

        // Create two sprites
        this.title = this.ecs.createEntity(30, 30).addSprite();
        this.card = this.ecs.createEntity(30, 83).addSprite();

        // Creates both texts
        this.timeLeft = this.ecs.createEntity(56, 91).addText("00:00:00", this.textStyle);
        this.playersLeft = this.ecs.createEntity(164, 91).addText("75/75 ALIVE", this.textStyle);

        // Anchor it in 0,0
        this.title.sprite.anchor.set(0.0);
        this.card.sprite.anchor.set(0.0);

        // Set sprite image
        this.title.setImg(this.app.loader.resources["thePitSmall"]);
        this.card.setImg(this.app.loader.resources["infoCard"]);

        // Add it to stage
        this.title.addStage(this.app);
        this.card.addStage(this.app);
        this.timeLeft.addStage(this.app);
        this.playersLeft.addStage(this.app);
    }

    onAttach() {

    }

    onUpdate(deltaTime: number) {}

    onDetach() {
        this.self.destroy();
    }
}

export { BattleStatusLayer };