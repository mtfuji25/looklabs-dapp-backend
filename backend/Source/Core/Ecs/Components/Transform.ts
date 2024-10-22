import { Vec2 } from "../../../Utils/Math";

class Transform {

    // Current Entity Position
    pos: Vec2;

    // Current Entity Scale
    scale: Vec2;

    constructor(x: number, y: number) {
        this.pos = new Vec2(x, y);
        this.scale = new Vec2(1.0, 1.0);
    }

    setPos(x: number, y: number) {
        this.pos.x = x;
        this.pos.y = y;
    }

    setScale(x: number, y: number) {
        this.scale.x = x;
        this.scale.y = y;
    }
}

export { Transform };
