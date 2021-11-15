import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

// Ecs and components
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";
import { Sprite } from "../../Core/Ecs/Components/Sprite";

interface TextParams {
    text: string;
    style: Partial<ITextStyle>;
    pos: { x: number; y: number };
}

class WinnerLayer extends Layer {
    private app: Application;
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
    private readonly sprites: Record<string, Sprite> = {};
    private readonly spriteKeys: string[] = [
        "resultCard",
        "nameCard",
        "tombstone",
        "clock",
        "purpleHeart",
        "purpleStarLeft",
        "purpleStarRight"
    ];
    private readonly textComponents: Record<string, Text> = {};
    private readonly texts: Record<string, TextParams> = {
        winner: {
            text: "WINNER",
            style: this.titleStyle,
            pos: { x: 31.2, y: 27 }
        },
        winnerName: {
            text: "Dog44",
            style: this.textStyle,
            pos: { x: 31.9, y: 61.7 }
        },
        kills: {
            text: "20",
            style: this.textStyle,
            pos: { x: 28.611, y: 66.3 }
        },
        health: {
            text: "21",
            style: this.textStyle,
            pos: { x: 33.2, y: 66.3 }
        },
        survived: {
            text: "Survived for",
            style: { ...this.textStyle, fontWeight: "400" },
            pos: { x: 28.611, y: 69.8 }
        },
        survivedTime: {
            text: "3:29:20",
            style: this.textStyle,
            pos: { x: 36.2, y: 69.8 }
        }
    };
    private winnerImg: Sprite;
    private percentX: number;
    private percentY: number;

    constructor(ecs: ECS, app: Application) {
        super("TesteLayer", ecs);

        this.app = app;

        // sets percents
        this.percentX = this.app.view.width / 100.0;
        this.percentY = this.app.view.height / 100.0;

        // generate all sprites
        this.spriteKeys.map((key, index) => {
            const component = this.ecs.createEntity().addSprite();
            component.setAnchor(0.0);
            this.sprites[key] = component;
            // because we will have 2 purpleStar sprites
            if (index >= 5) this.sprites[key].setImg(this.app.loader.resources["purpleStar"]);
            else this.sprites[key].setImg(this.app.loader.resources[key]);
            this.sprites[key].addStage(this.app);
        });

        // generate all texts
        Object.entries(this.texts).map(([key, value]) => {
            const component = this.ecs
                .createEntity(this.percentX * value.pos.x, this.percentY * value.pos.y)
                .addText(value.text, value.style);
            this.textComponents[key] = component;
            this.textComponents[key].addStage(this.app);
        });

        // initialize winner img
        this.winnerImg = this.ecs
            .createEntity(27.1 * this.percentX, 34.375 * this.percentY)
            .addSprite();
        
        this.winnerImg.setAnchor(0.0);
    }

    onAttach() {
        // Set all card positions
        this.sprites["resultCard"].setPos(this.percentX * 26.25, this.percentY * 33);
        this.sprites["nameCard"].setPos(this.percentX * 27.1, this.percentY * 60.625);
        this.sprites["tombstone"].setPos(this.percentX * 27.1, this.percentY * 66.5);
        this.sprites["purpleHeart"].setPos(this.percentX * 31.71, this.percentY * 66.5);
        this.sprites["clock"].setPos(this.percentX * 27.1, this.percentY * 69.875);
        this.sprites["purpleStarLeft"].setPos(this.percentX * 28.61, this.percentY * 27.1875);
        this.sprites["purpleStarRight"].setPos(this.percentX * 38.125, this.percentY * 27.1875);

        // Set cards scales
        this.scaleImg(this.sprites["resultCard"]);
        this.scaleImg(this.sprites["nameCard"]);

        // set winner img
        this.winnerImg.setFromUrl(
            "https://preview.redd.it/knfi88vdjdb61.jpg?width=640&crop=smart&auto=webp&s=f05a28bc4f2f23ae386c355aaeb7a0af581247f2"
        );

        this.winnerImg.setSize(200, 200);

        this.scaleImg(this.winnerImg);
    }

    onUpdate(deltaTime: number) {}

    onDetach() {
        this.self.destroy();
    }

    // scales image according to screen size
    scaleImg(sprite: Sprite) {
        const xScale = this.app.view.width / 1440;
        const yScale = this.app.view.height / 800;
        sprite.setScale(xScale, yScale);
    }
}

export { WinnerLayer };
