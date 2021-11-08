import { Vec2 } from "../../../utils/math";

class TransformComponent {

    pos: Vec2;
    scale: Vec2;

    constructor(x: number, y: number) {
        this.pos = new Vec2(x, y);
        this.scale = new Vec2(1.0, 1.0);
    }

}

export { TransformComponent };
