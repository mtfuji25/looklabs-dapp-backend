// Utils
import { Vec2 } from "../../../Utils/Math";

// Components imports
import { Transform } from "./Transform";

class Rectangle {

    width: number;
    height: number;

    transform: Transform;

    constructor(width: number, height: number, transform: Transform) {
        this.width = width;
        this.height = height;
        this.transform = transform;
    }

    getCenter(): Vec2 {
        return new Vec2(
            this.transform.pos.x,
            this.transform.pos.y
        );
    }

    getLuCorner(): Vec2 {
        return new Vec2(
            this.transform.pos.x - (this.width / 2.0),
            this.transform.pos.y + (this.height / 2.0)
        );
    }

    getLdCorner(): Vec2 {
        return new Vec2(
            this.transform.pos.x - (this.width / 2.0),
            this.transform.pos.y - (this.height / 2.0)
        );
    }

    getRuCorner(): Vec2 {
        return new Vec2(
            this.transform.pos.x + (this.width / 2.0),
            this.transform.pos.y + (this.height / 2.0)
        );
    }

    getRdCorner(): Vec2 {
        return new Vec2(
            this.transform.pos.x + (this.width / 2.0),
            this.transform.pos.y - (this.height / 2.0)
        );
    }

}

export { Rectangle };
