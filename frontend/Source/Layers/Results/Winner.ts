import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

// Ecs and components
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";
import { Sprite } from "../../Core/Ecs/Components/Sprite";
import { ScheduledGameParticipant } from "../../Clients/Strapi";

interface TextParams {
    text: string;
    style: Partial<ITextStyle>;
    pos: { x: number; y: number };
}

class WinnerLayer extends Layer {
    private app: Application;

    private percentX: number;
    private percentY: number;
    private winnerImg: Sprite;
    private participant: ScheduledGameParticipant;

    // Style objects for texts
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

    // Sprites record and constructors
    private readonly sprites: Record<string, Sprite> = {};
    private readonly spriteConstructors: Record<string, { x: number; y: number }> = {
        resultCard: { x: 26.25, y: 33 },
        nameCard: { x: 27.1, y: 60.625 },
        tombstone: { x: 27.1, y: 66.5 },
        purpleHeart: { x: 31.71, y: 66.5 },
        clock: { x: 27.1, y: 69.875 },
        purpleStarLeft: { x: 28.61, y: 27.1875 },
        purpleStarRight: { x: 38.125, y: 27.1875 }
    };

    // Texts record and constructors
    private readonly texts: Record<string, Text> = {};
    private readonly textConstructors: Record<string, TextParams> = {
        winner: {
            text: "WINNER",
            style: this.titleStyle,
            pos: { x: 31.2, y: 27 }
        },
        winnerName: {
            text: "",
            style: this.textStyle,
            pos: { x: 31.9, y: 61.7 }
        },
        kills: {
            text: "",
            style: this.textStyle,
            pos: { x: 28.611, y: 66.3 }
        },
        health: {
            text: "",
            style: this.textStyle,
            pos: { x: 33.2, y: 66.3 }
        },
        survived: {
            text: "Survived for",
            style: { ...this.textStyle, fontWeight: "400" },
            pos: { x: 28.611, y: 69.8 }
        },
        survivedTime: {
            text: "",
            style: this.textStyle,
            pos: { x: 36.2, y: 69.8 }
        }
    };

    constructor(ecs: ECS, app: Application, participant: ScheduledGameParticipant) {
        super("TesteLayer", ecs);

        this.app = app;

        this.participant = participant;

        // sets percents
        this.percentX = this.app.view.width / 100.0;
        this.percentY = this.app.view.height / 100.0;

        // generate all sprites
        Object.entries(this.spriteConstructors).map(([key, value], index) => {
            const component = this.ecs
                .createEntity(this.percentX * value.x, this.percentY * value.y)
                .addSprite();
            component.setAnchor(0.0);
            this.sprites[key] = component;
            // because we will have 2 purpleStar sprites
            if (index >= 5) this.sprites[key].setImg(this.app.loader.resources["purpleStar"]);
            else this.sprites[key].setImg(this.app.loader.resources[key]);
            this.sprites[key].addStage(this.app);
        });

        // generate all texts
        Object.entries(this.textConstructors).map(([key, value]) => {
            const component = this.ecs
                .createEntity(this.percentX * value.pos.x, this.percentY * value.pos.y)
                .addText(value.text, value.style);
            this.texts[key] = component;
            this.texts[key].addStage(this.app);
        });

        // initialize winner img
        this.winnerImg = this.ecs
            .createEntity(27.1 * this.percentX, 34.375 * this.percentY)
            .addSprite();

        this.winnerImg.setAnchor(0.0);
        this.winnerImg.addStage(this.app);
    }

    onAttach() {
        // Set cards scales
        this.scaleImg(this.sprites["resultCard"]);
        this.scaleImg(this.sprites["nameCard"]);

        // set winner img
        // this.winnerImg.setFromUrl(
        //     "http://i.imgur.com/eAbsZ.png"
        // );

        // this.winnerImg.setSize(50, 50);

        // this.scaleImg(this.winnerImg);

        // sets texts according to the winner
        this.texts["winnerName"].setText(this.participant.name);
        this.texts["kills"].setText(String(this.participant.game_participants_result.kills));
        this.texts["health"].setText(String(this.participant.game_participants_result.health));
        this.texts["survivedTime"].setText(
            this.formatTime(this.participant.game_participants_result.survived_for)
        );
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

    // Takes seconds and returns a string mm:ss
    formatTime(time: number): string {
        const minTwoDigits = (n: number) => {
            return (n < 10 ? "0" : "") + n;
        };

        const minutes = Math.floor(time / 60);
        const seconds = time - minutes * 60;

        return `${minTwoDigits(minutes)}:${minTwoDigits(seconds)}`;
    }
}

export { WinnerLayer };
