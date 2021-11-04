import { RectangleComponent } from "../core/ecs/components/rectangle";
import { RigidbodyComponent } from "../core/ecs/components/rigidbody";

interface CollisionResult {
    contactPoint: Vec2;
    contactNormal: Vec2;
    contactTime: number;
}

const rayIntersectRec = (rayOrigin: Vec2, rayDir: Vec2, recTarget: RectangleComponent, results: CollisionResult) => {
    let lu = recTarget.getLuCorner();
    let rd = recTarget.getRdCorner();

    const tNear= new Vec2(
        (lu.x - rayOrigin.x) / rayDir.x,
        (lu.y - rayOrigin.y) / rayDir.y
    );

    if (tNear.x == NaN || tNear.x == Infinity || tNear.x == -Infinity
        ||
        tNear.y == NaN || tNear.y == Infinity || tNear.y == -Infinity) return false;

    const tFar = new Vec2(
        (rd.x - rayOrigin.x) / rayDir.x, 
        (rd.y - rayOrigin.y) / rayDir.y
    );

    if (tFar.x == NaN || tFar.x == Infinity || tFar.x == -Infinity
        ||
        tFar.y == NaN || tFar.y == Infinity || tFar.y == -Infinity) return false; 

    if (tNear.x > tFar.x)
        [ tNear.x, tFar.x ] = [ tFar.x, tNear.x ];
    if (tNear.y > tFar.y)
        [ tNear.y, tFar.y ] = [ tFar.y, tNear.y ];

    if (tNear.x > tFar.y || tNear.y > tFar.x)
        return false;

    const tHitNear: number = Math.max(tNear.x, tNear.y);
    const tHitFar: number = Math.min(tFar.x, tFar.y);

    if (tHitFar < 0)
        return false;

    const hitPoint = new Vec2(
        rayOrigin.x + tHitNear * rayDir.x,
        rayOrigin.y + tHitNear * rayDir.y
    );

    let hitNormal = new Vec2();

    if (tNear.x > tNear.y) {
        if (rayDir.x < 0) {
            hitNormal.x = 1;
            hitNormal.y = 0;
        } else {
            hitNormal.x = -1;
            hitNormal.y = 0;
        }
    } else if (tNear.x < tNear.y) {
        if (rayDir.y < 0) {
            hitNormal.x = 0;
            hitNormal.y = 1;
        } else {
            hitNormal.x = 0;
            hitNormal.y = -1;
        }
    }
        
    results.contactPoint = hitPoint;
    results.contactNormal = hitNormal;
    results.contactTime = tHitNear;

    return true;            
}

const recIntersectRec = (a: RigidbodyComponent, b: RigidbodyComponent, deltaTime: number, results: CollisionResult) => {
    if (a.velocity.x == 0 && a.velocity.y == 0)
        return false;

    let expanded = new RectangleComponent(
        b.rectangle.width + a.rectangle.width,
        b.rectangle.height + a.rectangle.height,
        b.rectangle.transform
    );

    if (rayIntersectRec(a.rectangle.getCenter(), a.velocity.muls(deltaTime), expanded, results)) {
        if (results.contactTime >= 0.0 && results.contactTime < 1.0)
            return true;
    }

    return false;
}

export { rayIntersectRec, recIntersectRec };