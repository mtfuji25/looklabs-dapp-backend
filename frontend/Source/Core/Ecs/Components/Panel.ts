// Components imports
import { Transform } from "./Transform";

// Pixi imports
import { Application, Container, LoaderResource, NineSlicePlane } from "pixi.js";

class Panel {

    public refresh: boolean = true;

    public transform: Transform;

    public img: LoaderResource;
    public sprite: NineSlicePlane;

    private app: Application | null = null;
    private container: Container | null = null;

    constructor(transform: Transform, res: LoaderResource) {
        this.transform = transform;
        this.img = res;
        this.sprite = new NineSlicePlane(res.texture);
        this.sprite.x = this.transform.pos.x;
        this.sprite.y = this.transform.pos.y;
    }
    
    setImg(img: LoaderResource) {
        this.img = img;
        this.sprite.x = this.transform.pos.x;
        this.sprite.y = this.transform.pos.y;
        this.sprite.texture = img.texture;
    }
    
    addStage(app: Application | Container) {
        if (app instanceof Application) {
            if (!this.app) {
                this.app = app;
                app.stage.addChild(this.sprite);
            } else {
                this.remStage();
                this.app = app;
                app.stage.addChild(this.sprite);
            }
        } else {
            if (!this.container) {
                this.container = app;
                app.addChild(this.sprite);
            } else {
                this.remStage();
                this.container = app;
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

    setSlices (leftWidth: number, topHeight: number, rightWidth: number, bottomHeight: number) {
        this.sprite.leftWidth = leftWidth;
        this.sprite.topHeight = topHeight;
        this.sprite.rightWidth = rightWidth;
        this.sprite.bottomHeight = bottomHeight;
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

    setSize(width: number, height: number) {
        this.setWidth(width);
        this.setHeight(height);
    }

    setWidth (width:number) {
        this.sprite.width = width;
        const scaleX = width / this.sprite.width;
        this.transform.scale.x = scaleX;
        this.sprite.scale.x = scaleX;
    }

    setHeight (height:number) {
        this.sprite.height = height;
        const scaleY = height / this.sprite.height;
        this.transform.scale.y = scaleY;
        this.sprite.scale.y = scaleY;
    }

}

export { Panel };