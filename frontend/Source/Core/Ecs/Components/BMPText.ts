import { Vec2 } from "../../../Utils/Math";

// Components imports
import { Transform } from "./Transform";

// Pixi imports
import { Application, BitmapText, Container, IBitmapTextStyle } from "pixi.js";

class BMPText {

    public refresh: boolean = true;

    public transform: Transform;

    public text: BitmapText;

    // Current attached app
    private app: Application | null = null;
    private container: Container | null = null;

    constructor(transform: Transform, text: string, styles: Partial<IBitmapTextStyle>) {
        this.transform = transform;
        this.text = new BitmapText(text, styles);
    }

    setText(text: string) {
        this.text.text = text;
    }

    addStage(app: Application | Container) {
        if (app instanceof Application) {
            if (!this.app) {
                this.app = app;
                app.stage.addChild(this.text);
            } else {
                this.remStage();
                this.app = app;
                app.stage.addChild(this.text);
            }
        } else {
            if (!this.container) {
                this.container = app;
                app.addChild(this.text);
            } else {
                this.remStage();
                this.container = app;
                app.addChild(this.text);
            }
        }
    }

    remStage() {
        if (this.app)
            this.app.stage.removeChild(this.text);
          
        if (this.container)
            this.container.removeChild(this.text);
    }

    setScale(x: number, y: number) {
        this.transform.scale.x = x;
        this.transform.scale.y = y;
    }

    setPos(x: number, y: number) {
        this.transform.pos.x = x;
        this.transform.pos.y = y;
        this.text.x = x;
        this.text.y = y;
    }
    
    getSize ():Vec2 {
        
        return new Vec2(this.text.width, this.text.height);
    }


    
}

export { BMPText };