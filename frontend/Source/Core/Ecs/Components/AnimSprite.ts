
// Components imports
import { Transform } from "./Transform";

// Pixi imports
import { Application, Container, BaseTexture, Texture, Rectangle, AnimatedSprite } from "pixi.js";
import { Vec2 } from "../../../Utils/Math";
type Frame = {
    x: number;
    y: number;
    width: number;
    height: number;
}
type AnimConfig = {
    resource: string;
    speed: number;
    anchor: number;
    loop: boolean;
    texWidth: number;
    texHeight: number;
    animations: Array<string>;
} & {
    [animation: string]: Array<Frame>;
};

class AnimSprite {

    public refresh: boolean = true;

    public transform: Transform;

    private ssheet: BaseTexture;
    private sprites: Record<string, Array<Texture>> = {};
    
    public sprite: Container;
    public animSprite:AnimatedSprite;

    private texWidth: number = 0;
    private texHeight: number = 0;

    private app: Application | null = null;
    private container: Container | null = null;

    constructor(transform: Transform) {
        this.transform = transform;
    }
    
    createContainer () {
        this.sprite = new Container();
        this.sprite.x = this.transform.pos.x;
        this.sprite.y = this.transform.pos.y;
    }

    loadFromConfig(app: Application, config: AnimConfig, res:string = null, offset:boolean = false) {

        const url: string = res === null ? app.loader.resources[config["resource"]].url : res;
        this.ssheet = BaseTexture.from(url);

        this.texWidth = config["texWidth"];
        this.texHeight = config["texHeight"];
        
        config["animations"].forEach((animation) => {
            config[animation].forEach((frame) => {
                if (!this.sprites[animation])
                    this.sprites[animation] = new Array<Texture>();

                this.sprites[animation].push(
                    new Texture(this.ssheet, new Rectangle(
                        frame.x, frame.y, frame.width, frame.height
                    ))
                );
            });
        });

        this.animSprite = new AnimatedSprite(this.sprites[config["animations"][0]]);
        this.animSprite.animationSpeed = config["speed"];
        this.animSprite.loop = config["loop"];
        this.animSprite.anchor.set(config["anchor"]);
        if (offset) {
            this.animSprite.y = -this.animSprite.height * 0.25;
        }
        
        this.sprite.addChild(this.animSprite);
    }

    animate(animation: string) {
        if (this.animSprite && !this.animSprite.playing) {
            this.animSprite.textures = this.sprites[animation];
            this.animSprite.play();
        }
    }

    forceAnimate(animation: string) {
        if (this.animSprite) {
            this.animSprite.textures = this.sprites[animation];
            this.animSprite.play();
        }
    }

    addStage(app: Application | Container, index:number = -1) {
        if (app instanceof Application) {
            if (!this.app) {
                this.app = app;
            } else {
                this.remStage();
                this.app = app;
            }
            if (index >= 0) {
                app.stage.addChildAt(this.sprite, index);
            } else {
                app.stage.addChild(this.sprite);
            }
            
        } else {
            if (!this.container) {
                this.container = app;
            } else {
                this.remStage();
                this.container = app;
            }
            if (index >= 0) {
                app.addChildAt(this.sprite, index);
            } else {
                app.addChild(this.sprite);
            }
            
        }
    }

    remStage() {
        if (this.app)
            this.app.stage.removeChild(this.sprite);
          
        if (this.container)
            this.container.removeChild(this.sprite);
    }

    setScale(x: number, y: number) {
        this.transform.scale.x = x;
        this.transform.scale.y = y;
    }

    setPos(x: number, y: number) {
        this.transform.pos.x = x;
        this.transform.pos.y = y;
        this.sprite.x = x;
        this.sprite.y = y;
    }

}

export { AnimSprite, AnimConfig };