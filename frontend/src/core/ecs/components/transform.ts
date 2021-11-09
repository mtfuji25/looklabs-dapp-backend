import { Vec2 } from "../../../utils/math";

class TransformComponent {

    // Position and scale
    pos: Vec2;
    scale: Vec2;

    // Global offset
    offsetX: number = 0;
    offsetY: number = 0;

    zoom = 0.0;

    constructor(x: number, y: number) {
        this.pos = new Vec2(x, y);
        this.scale = new Vec2(1.0, 1.0);
    }

    setScale(x: number, y: number) {
        this.scale = new Vec2(x, y);
    }

}

export { TransformComponent };