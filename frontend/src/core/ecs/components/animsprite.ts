import { Vec2 } from "../../../utils/math";
import { TransformComponent } from "./transform";

import { Application, BaseTexture, Texture, Rectangle, AnimatedSprite } from "pixi.js";

type AnimConfig = {
    resource: string;
    speed: number;
    loop: boolean;
    texWidth: number;
    texHeight: number;
    frameWidth: number;
    frameHeigth: number;
    animations: Array<string>;
} & {
    [animation: string]: Array<Array<number>>;
};

class AnimSpriteComponent {

    public transform: TransformComponent;

    private ssheet: BaseTexture;
    private sprites: Record<string, Array<Texture>> = {};
    
    public sprite: AnimatedSprite;

    private texWidth: number = 0;
    private texHeight: number = 0;

    private frameWidth: number = 0;
    private frameHeight: number = 0;

    constructor(transform: TransformComponent) {
        this.transform = transform;
    }

    loadFromConfig(app: Application, config: AnimConfig) {

        const url: string = app.loader.resources[config["resource"]].url;
        this.ssheet = BaseTexture.from(url);

        this.texWidth = config["texWidth"];
        this.texHeight = config["texHeight"];
        this.frameWidth = config["frameWidth"];
        this.frameHeight = config["frameHeigth"];
        
        config["animations"].forEach((animation) => {
            config[animation].forEach((frame) => {
                if (!this.sprites[animation])
                    this.sprites[animation] = new Array<Texture>();

                this.sprites[animation].push(
                    new Texture(this.ssheet, new Rectangle(
                        frame[1] * this.frameWidth, frame[0] * this.frameHeight,
                        this.frameWidth, this.frameHeight
                    ))
                );
            });
        });

        this.sprite = new AnimatedSprite(this.sprites[config["animations"][0]]);
        this.sprite.animationSpeed = config["speed"];
        this.sprite.loop = config["loop"];

        this.sprite.anchor.set(0.5);
        this.sprite.x = this.transform.pos.x;
        this.sprite.y = this.transform.pos.y;
    }

    animate(animation: string) {
        if (!this.sprite.playing) {
            this.sprite.textures = this.sprites[animation];
            this.sprite.play();
        }
    }

    addStage(app: Application) {
        app.stage.addChild(this.sprite);
    }

    remStage(app: Application) {
        app.stage.removeChild(this.sprite);
    }

    setScale(x: number, y: number) {
        this.sprite.scale.x = x;
        this.sprite.scale.y = y;
    }

}

export { AnimSpriteComponent };
