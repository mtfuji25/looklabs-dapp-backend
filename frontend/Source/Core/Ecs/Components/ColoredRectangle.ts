import { Vec2 } from "../../../Utils/Math";

// Components imports
import { Transform } from "./Transform";

// Pixi imports
import { Application, Graphics } from "pixi.js";

class ColoredRectangle {
    public width: number;
    public height: number;
    public color: number;

    public sprite = {
        x: 0.0,
        y: 0.0,
        scale: {
            x: 0.0,
            y: 0.0
        }
    }

    public refresh: boolean = true;

    public transform: Transform;
    
    public graphics: Graphics;

    private app: Application | null = null;

    constructor(transform: Transform, width: number, height: number, color: number) {
        this.transform = transform;
        this.width = width;
        this.height = height;
        this.color = color;

        this.graphics = new Graphics();

        this.graphics.beginFill(color);

        this.graphics.drawRect(transform.pos.x, transform.pos.y, width, height);

        this.graphics.endFill();

    }

    setSize(width: number, height: number) {
        this.width = width;
        this.height = height;
    }

    setColor(color: number) {
        this.color = color;
    }

    addStage(app: Application) {
        if (!this.app) {
            this.app = app;
            this.app.stage.addChild(this.graphics);
        } else {
            this.remStage();
            this.app = app;
            this.app.stage.addChild(this.graphics);
        }
    }

    remStage() {
        if (!this.app)
            return;
            
        this.app.stage.removeChild(this.graphics);
    }

    setScale(x: number, y: number) {
        this.transform.scale.x = x;
        this.transform.scale.y = y;
    }

    setPos(x: number, y: number) {
        this.transform.pos.x = x;
        this.transform.pos.y = y;
    }

}

export { ColoredRectangle };