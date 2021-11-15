import { Vec2 } from "../../../Utils/Math";

// Components imports
import { Rectangle } from "./Rectangle";

// Collisions imports
import { CollisionResult, recIntersectRec, recIntersectStatic } from "../../../Utils/Collisions";

class Rigidbody {

    velocity: Vec2;

    rectangle: Rectangle;

    constructor(rectangle: Rectangle) {
        this.rectangle = rectangle;
        this.velocity = new Vec2();
    }

    colide(other: Rigidbody, deltaTime: number): CollisionResult {
        let results: CollisionResult = {
            contactPoint: new Vec2(),
            contactNormal: new Vec2(),
            contactTime: 0.0,
            intersect: false
        }

        results.intersect = recIntersectRec(this, other, deltaTime, results);

        return results;
    }

    colideStatic(other: Rectangle, deltaTime: number): CollisionResult {
        let results: CollisionResult = {
            contactPoint: new Vec2(),
            contactNormal: new Vec2(),
            contactTime: 0.0,
            intersect: false
        }

        results.intersect = recIntersectStatic(this, other, deltaTime, results);

        return results;
    }
}

export { Rigidbody };
