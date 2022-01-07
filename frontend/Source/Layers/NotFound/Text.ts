import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

// Ecs and Components
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";
import { Sprite } from "../../Core/Ecs/Components/Sprite";

class TextLayer extends Layer {
    private app: Application;
    private title: Sprite;
    private subtitle: Text;
    private percentX: number;
    private percentY: number;

    private screenX: number;
    private screenY: number;

    // Styles
    private readonly titleStyle: Partial<ITextStyle> = {
        fontFamily: "Dealers",
        fontSize: "96px",
        fill: 0xffffff,
        align: "center",
        fontWeight: "700"
    };

    // count that resets every second
    private fiveSecCount: number = 0.0;

    constructor(ecs: ECS, app: Application) {
        super("TesteLayer", ecs);

        this.app = app;
        // sets percents
        this.percentX = this.app.view.clientWidth / 100.0;
        this.percentY = this.app.view.clientHeight / 100.0;

        this.screenX = this.app.view.clientWidth;
        this.screenY = this.app.view.clientHeight;

        this.title = this.ecs.createEntity().addSprite(this.app.loader.resources["thepit"]);
        // Anchor it in 0,0
        this.title.sprite.anchor.set(0.0);
        
        // Add it to stage
        this.title.addStage(this.app);
        
    }

    renderText(text: Text, y: number) {
        text.setPos(
            this.percentX * 50 - text.text.width / 2.0,
            this.percentY * y - text.text.height / 2.0
        );
        
        text.addStage(this.app);
    }

    onAttach() {
        this.subtitle = this.ecs.createEntity().addText("NEXT BATTLE SOON", this.titleStyle);

        this.renderText(this.subtitle, 50);

        this.title.setPos((this.screenX - this.title.sprite.width) * 0.5, this.subtitle.text.y - 200);
    }

    onUpdate(deltaTime: number) {
        if(this.app.view.clientWidth !== this.screenX || this.app.view.clientHeight !== this.screenY) {
            // resets percentages
            this.percentX = this.app.view.clientWidth / 100.0;
            this.percentY = this.app.view.clientHeight / 100.0;

            this.screenX = this.app.view.clientWidth;
            this.screenY = this.app.view.clientHeight;

            this.subtitle.setPos(
                this.percentX * 50 - this.subtitle.text.width / 2.0,
                this.percentY * 50 - this.subtitle.text.height / 2.0
            );

            this.title.setPos((this.screenX - this.title.sprite.width) * 0.5, this.subtitle.text.y - 200);
        }   
    }

    onDetach() {}
}

export { TextLayer };
