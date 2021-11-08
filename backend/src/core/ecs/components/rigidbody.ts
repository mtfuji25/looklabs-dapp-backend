import { CollisionResult, recIntersectRec, recIntersectStatic } from "../../../utils/collision";
import { Vec2 } from "../../../utils/math";
import { Entity } from "../core/ecs";
import { RectangleComponent } from "./rectangle";

type OnCollisionFn = (other: Entity | null, result: CollisionResult) => (void);

class RigidbodyComponent {

    velocity: Vec2;

    rectangle: RectangleComponent;

    onCollision: OnCollisionFn = (a, b) => {};

    constructor(rectangle: RectangleComponent) {
        this.rectangle = rectangle;
        this.velocity = new Vec2();
    }

    colide(other: RigidbodyComponent, deltaTime: number): CollisionResult {
        let results: CollisionResult = {
            contactPoint: new Vec2(),
            contactNormal: new Vec2(),
            contactTime: 0.0,
            intersect: false
        }

        results.intersect = recIntersectRec(this, other, deltaTime, results);

        return results;
    }

    colideStatic(other: RectangleComponent, deltaTime: number): CollisionResult {
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

export { RigidbodyComponent };
