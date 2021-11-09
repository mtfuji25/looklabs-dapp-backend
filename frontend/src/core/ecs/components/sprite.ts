import { Vec2 } from "../../../utils/math";
import { TransformComponent } from "./transform";

import { Application, Sprite, LoaderResource, BaseTexture, Texture, Rectangle } from "pixi.js";

class SpriteComponent {

    public transform: TransformComponent;

    public img: LoaderResource;
    public sprite: Sprite;

    public useView: boolean = true;

    constructor(transform: TransformComponent) {
        this.transform = transform;

        this.sprite = new Sprite();
        this.sprite.anchor.set(0.5);
        this.sprite.x = this.transform.pos.x;
        this.sprite.y = this.transform.pos.y;
    }

    setCutImg(img: LoaderResource, pw: number, ph: number, w: number, h: number) {
        const url: string = img.url;
        const ssheet: BaseTexture = BaseTexture.from(url);
        const texture = new Texture(ssheet, new Rectangle(pw, ph, w, h));

        this.sprite.texture = texture;
    }

    setImg(img: LoaderResource) {
        this.img = img;
        this.sprite.texture = img.texture;
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

export { SpriteComponent };