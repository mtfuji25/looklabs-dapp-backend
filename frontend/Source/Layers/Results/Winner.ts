import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, Container, ITextStyle } from "pixi.js";

// Ecs and components
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";
import { Sprite } from "../../Core/Ecs/Components/Sprite";
import { ParticipantDetails, ScheduledGameParticipant } from "../../Clients/Strapi";
import { PlayerLayer } from "../Lobby/Player";

interface TextParams {
    text: string;
    style: Partial<ITextStyle>;
    pos: { x: number; y: number };
}

class WinnerLayer extends Layer {
    private app: Application;

    private screenX: number;
    private screenY: number;
    private percentX: number;
    private percentY: number;
    private winnerImg: Sprite;
    private details: ParticipantDetails;
    private participant: ScheduledGameParticipant

    // Style objects for texts
    private readonly textStyle: Partial<ITextStyle> = {
        fontFamily: "Space Mono",
        fontSize: 16,
        fill: 0xffffff,
        align: "center",
        fontWeight: "700",
        lineHeight: 22.4
    };
    private readonly titleStyle: Partial<ITextStyle> = {
        ...this.textStyle,
        fontFamily: "dealers",
        fontSize: "36px",
        lineHeight: 36,
        fontWeight: "400"
    };

    // Sprites record and constructors
    private readonly sprites: Record<string, Sprite> = {};
    private readonly spriteConstructors: string[] = ["resultCard", "nameCard", "tombstone", "purpleHeart", "clock", "characterLeft", "characterRight"];
    
    // Texts record and constructors
    private readonly texts: Record<string, Text> = {};
    private readonly textConstructors: Record<string, TextParams> = {
        winner: {
            text: "WINNER!",
            style: this.titleStyle,
            pos: { x: 31, y: 26 }
        },
        winnerName: {
            text: "",
            style: this.textStyle,
            pos: { x: 34, y: 61.8 }
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
            text: "Survived",
            style: { ...this.textStyle, fontWeight: "400" },
            pos: { x: 28.611, y: 69.8 }
        },
        survivedTime: {
            text: "",
            style: this.textStyle,
            pos: { x: 36.2, y: 69.8 }
        }
    };

    private container:Container;
    
    constructor(ecs: ECS, 
                app: Application, 
                participant: ScheduledGameParticipant, 
                details: ParticipantDetails ) {

        super("TesteLayer", ecs);

        this.app = app;
        
        this.details = details;
        this.participant = participant;

        // sets percents
        this.percentX = this.app.view.clientWidth / 100.0;
        this.percentY = this.app.view.clientHeight / 100.0;
        this.screenX = this.app.view.clientWidth;
        this.screenY = this.app.view.clientHeight;

        this.container = new Container();
        this.app.stage.addChild(this.container);
        this.container.visible = false;

        this.spriteConstructors.map((key) => {
            const component = this.ecs
                .createEntity()
                .addSprite();
            component.setAnchor(0.0);
            this.sprites[key] = component;
            this.sprites[key].setImg(this.app.loader.resources[key]);
            this.container.addChild(this.sprites[key].sprite);
        });

        Object.entries(this.textConstructors).map(([key, value]) => {
            const component = this.ecs
            // this.percentX * value.pos.x, this.percentY * value.pos.y
                .createEntity()
                .addText(value.text, value.style);
            
            this.texts[key] = component;
            this.container.addChild(this.texts[key].text);
            this.texts[key].text.anchor.set(0.5,0.5);
        });
        // initialize winner img
        this.winnerImg = this.ecs
            .createEntity()
            .addSprite();
        this.container.addChild(this.winnerImg.sprite);


        this.winnerImg.setFromUrl(
            this.details.image, (tx) => {
                this.renderWinner();
            }
        );
        
        this.texts["winnerName"].setText(PlayerLayer.lastGamePlayerNames[this.participant.nft_id]);
        this.texts["kills"].setText(String(this.participant.game_participants_result.kills));
        this.texts["health"].setText(String(this.participant.game_participants_result.health));
        this.texts["survivedTime"].setText(
            this.formatTime(this.participant.game_participants_result.survived_for)
        );

    }

    onAttach() {
        this.renderWinner();
    }

    renderWinner () {
        if (!this.winnerImg.sprite || !this.winnerImg.sprite.texture) return;

        const baseHeight = this.app.view.clientHeight * 0.5;
        const scale = baseHeight/this.sprites["resultCard"].sprite.texture.height;    
        this.sprites["resultCard"].sprite.anchor.set(0,0);
        this.sprites["resultCard"].setScale( scale, scale);
        const baseWidth = this.sprites["resultCard"].sprite.texture.width * scale;
        
        const imageScale = (baseWidth * 0.9) / this.winnerImg.sprite.texture.width;
        this.winnerImg.sprite.anchor.set(0,0);
        this.winnerImg.setScale(imageScale, imageScale);
        this.winnerImg.setPos(baseWidth * 0.05, baseWidth * 0.05);

        
        this.sprites["nameCard"].sprite.anchor.set(0,0);
        this.sprites["nameCard"].setScale(scale, scale);
        this.sprites["nameCard"].setPos(baseWidth * 0.06, baseHeight * 0.68);

        this.sprites["tombstone"].sprite.anchor.set(0,0);
        this.sprites["tombstone"].setScale(scale, scale);
        this.sprites["tombstone"].setPos(baseWidth * 0.06, baseHeight * 0.82);

        this.sprites["clock"].sprite.anchor.set(0,0);
        this.sprites["clock"].setScale(scale, scale);
        this.sprites["clock"].setPos(baseWidth * 0.06, baseHeight * 0.92);

        this.sprites["purpleHeart"].sprite.anchor.set(0,0);
        this.sprites["purpleHeart"].setScale(scale, scale);
        this.sprites["purpleHeart"].setPos(baseWidth * 0.7, baseHeight * 0.825);

        this.sprites["characterLeft"].sprite.anchor.set(0,0);
        this.sprites["characterLeft"].setScale(scale, scale);
        this.sprites["characterLeft"].setPos(baseWidth * 0.05, baseHeight * -0.12);

        this.sprites["characterRight"].sprite.anchor.set(0,0);
        this.sprites["characterRight"].setScale(scale, scale);
        this.sprites["characterRight"].setPos(baseWidth * 0.82, baseHeight * -0.12);

        this.texts["winner"].setScale(scale, scale);
        this.texts["winner"].setPos(baseWidth * 0.5, baseHeight * -0.08);

        this.texts["winnerName"].setScale(scale * 0.75, scale * 0.75);
        this.texts["winnerName"].setPos(baseWidth * 0.5, baseHeight * 0.74);

        this.texts["kills"].setScale(scale * 0.7 , scale * 0.7);
        this.texts["kills"].setPos(baseWidth * 0.18, baseHeight * 0.855);

        this.texts["survived"].setScale(scale * 0.7, scale * 0.7);
        this.texts["survived"].setPos(baseWidth * 0.28, baseHeight * 0.955);

        this.texts["health"].setScale(scale * 0.7, scale * 0.7);
        this.texts["health"].setPos(baseWidth * 0.83, baseHeight * 0.855);

        this.texts["survivedTime"].setScale(scale * 0.7, scale * 0.7);
        this.texts["survivedTime"].setPos(baseWidth * 0.85, baseHeight * 0.955);

        this.container.x = this.app.view.clientWidth * 0.2;
        this.container.y = this.app.view.clientWidth * 0.1;
        
        this.container.visible = true;
    }

    onUpdate(deltaTime: number) {
        
        // on window resize 
        if(this.app.view.clientWidth !== this.screenX || this.app.view.clientHeight !== this.screenY) {
            // resets percentages
            this.percentX = this.app.view.clientWidth / 100.0;
            this.percentY = this.app.view.clientHeight / 100.0;
            this.renderWinner();
        }

    }

    onDetach() {
        this.container.removeChildren();
        this.app.stage.removeChild(this.container);
    }

    // scales image according to screen size
    scaleImg(sprite: Sprite) {
        const xScale = this.app.view.clientWidth / 1440;
        const yScale = this.app.view.clientHeight / 800;
        sprite.setScale(xScale, yScale);
    }

    // Takes seconds and returns a string mm:ss
    formatTime(time: number): string {
        const minTwoDigits = (n: number) => {
            return (n < 10 ? "0" : "") + n;
        };
        const total_seconds = time / 1000;
        const minutes = Math.floor(total_seconds / 60);
        const seconds = Math.floor(total_seconds - (minutes * 60));

        return `${minTwoDigits(minutes)}:${minTwoDigits(seconds)}`;
    }
}

export { WinnerLayer };
