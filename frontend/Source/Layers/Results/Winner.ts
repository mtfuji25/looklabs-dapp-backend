import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

// Ecs and components
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";
import { Sprite } from "../../Core/Ecs/Components/Sprite";

class WinnerLayer extends Layer {
    private app: Application;
    private sprites: Record<string, Sprite> = {};
    private readonly textStyle: Partial<ITextStyle> = {
        fontFamily: "monospace",
        fontSize: 16,
        fill: 0xffffff,
        align: "center",
        fontWeight: "700",
        lineHeight: 22.4
    };
    private readonly titleStyle: Partial<ITextStyle> = {
        ...this.textStyle,
        fontSize: 24,
        lineHeight: 31
    };
    private readonly spriteKeys: string[] = [
        "resultCard",
        "nameCard",
        "tombstone",
        "clock",
        "purpleHeart",
        "purpleStarLeft",
        "purpleStarRight"
    ];
    private textsComponents: Record<string, Text> = {};
    private readonly texts: Record<string, Object> = {
        "winner": {text: "WINNER", style: this.titleStyle},
        "winnerName": {text: "Dog44", style: this.textStyle},
        "kills": {text: "20", style: this.textStyle},
        "health": {text: "21", style: this.textStyle},
        "survived": {text: "Survived for", style: {...this.textStyle, fontWeight: "400"}},
        "survivedTime": {text: "WINNER", style: this.textStyle},
    }
    private winnerImg: Sprite;
    // first index is left one, second the right one
    private percentX: number;
    private percentY: number;

    // const titleEntity = this.ecs.createEntity(
    //     58.4022 * this.percentX,
    //     5.25 * this.percentY
    // );
    // this.title = titleEntity.addComponent[Text]("RESULTS", this.titleStyle) as TextComponent;
    // this.title.addStage(this.app);


    constructor(ecs: ECS, app: Application) {
        super("TesteLayer", ecs);

        this.app = app;

        // sets percents
        this.percentX = this.app.view.width / 100.0;
        this.percentY = this.app.view.height / 100.0;        

        this.spriteKeys.map((key, index) => {
            const component = this.ecs.createEntity().addSprite();
            component.sprite.anchor.set(0.0);
            this.sprites[key] = component;
            // because we will have 2 purpleStar sprites
            if (index >= 5)
                this.sprites[key].setImg(
                    this.app.loader.resources["purpleStar"]
                );
            else this.sprites[key].setImg(this.app.loader.resources[key]);
            this.sprites[key].addStage(this.app);
        });

        // this.textKeys.map((key, index) => {
        //     const entity = this.ecs.createEntity();
        //     const component = entity.addComponent[Sprite]() as SpriteComponent;
        //     component.sprite.anchor.set(0.0);
        //     this.sprites[key] = component;
        //     // because we will have 2 purpleStar sprites
        //     if (index >= 5)
        //         this.sprites[key].setImg(
        //             this.app.loader.resources["purpleStar"]
        //         );
        //     else this.sprites[key].setImg(this.app.loader.resources[key]);
        //     this.sprites[key].addStage(this.app);
        // });
    }

    onAttach() {
        //TODO: SCALE RESULTCARD
        this.sprites["resultCard"].setPos(this.percentX * 26.25, this.percentY * 33);
        this.sprites["nameCard"].setPos(this.percentX * 27.1, this.percentY * 60.625);
        this.sprites["tombstone"].setPos(this.percentX * 27.1, this.percentY * 66.5);
        this.sprites["purpleHeart"].setPos(this.percentX * 31.71, this.percentY * 66.5);
        this.sprites["clock"].setPos(this.percentX * 27.1, this.percentY * 69.875);
        this.sprites["purpleStarLeft"].setPos(this.percentX * 27.61, this.percentY * 27.1875);
        this.sprites["purpleStarRight"].setPos(this.percentX * 38, this.percentY * 27.1875);
    }

    onUpdate(deltaTime: number) {}

    onDetach() {
        this.self.destroy();
    }

    renderText(text: Text, x: number, y: number) {
        text.setPos(this.percentX * x,this.percentY * y )
        text.addStage(this.app);
    }
}

export { WinnerLayer };