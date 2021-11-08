import { Vec2 } from "./math";
import { RectangleComponent } from "../core/ecs/components/rectangle";
import { RigidbodyComponent } from "../core/ecs/components/rigidbody";

interface CollisionResult {
    contactPoint: Vec2;
    contactNormal: Vec2;
    contactTime: number;
    intersect: boolean;
}

//
//  Checks if a ray intersects one given rectangle
//

const rayIntersectRec = (rayOrigin: Vec2, rayDir: Vec2, recTarget: RectangleComponent, results: CollisionResult) => {
    let lu = recTarget.getLuCorner();
    let rd = recTarget.getRdCorner();

    const invdir = new Vec2(
        1.0 / rayDir.x,
        1.0 / rayDir.y 
    );

    const tNear = new Vec2(
        (lu.x - rayOrigin.x) * invdir.x,
        (lu.y - rayOrigin.y) * invdir.y
    );

    if (tNear.x == NaN || tNear.y == NaN) return false;

    const tFar = new Vec2(
        (rd.x - rayOrigin.x) * invdir.x, 
        (rd.y - rayOrigin.y) * invdir.y
    );

    if (tFar.x == NaN || tFar.y == NaN) return false; 

    if (tNear.x > tFar.x)
        [ tNear.x, tFar.x ] = [ tFar.x, tNear.x ];
    if (tNear.y > tFar.y)
        [ tNear.y, tFar.y ] = [ tFar.y, tNear.y ];

    if (tNear.x > tFar.y || tNear.y > tFar.x) return false;

    const tHitNear: number = Math.max(tNear.x, tNear.y);
    const tHitFar: number = Math.min(tFar.x, tFar.y);

    if (tHitFar < 0) return false;

    results.contactTime = tHitNear;
    results.contactPoint.x = rayOrigin.x + tHitNear * rayDir.x;
    results.contactPoint.y = rayOrigin.y + tHitNear * rayDir.y;

    if (tNear.x > tNear.y) {
        if (invdir.x < 0) {
            results.contactNormal.x = 1;
            results.contactNormal.y = 0;
        } else {
            results.contactNormal.x = -1;
            results.contactNormal.y = 0;
        }
    } else if (tNear.x < tNear.y) {
        if (invdir.y < 0) {
            results.contactNormal.x = 0;
            results.contactNormal.y = 1;
        } else {
            results.contactNormal.x = 0;
            results.contactNormal.y = -1;
        }
    }

    return true;            
}

//
//  Checks if a dynamic rectangle intersects other dynamic rectangle
//

const recIntersectRec = (a: RigidbodyComponent, b: RigidbodyComponent, deltaTime: number, results: CollisionResult) => {
    
    // Rejects if origin rectangles does not has velocity
    if (a.velocity.x == 0 && a.velocity.y == 0)
        return false;

    // Expanded target rectangle
    const expanded = new RectangleComponent(
        b.rectangle.width + a.rectangle.width,
        b.rectangle.height + a.rectangle.height,
        b.rectangle.transform
    );

    // Direction vector of origin rectangle
    const direction = a.velocity.sub(b.velocity).muls(deltaTime);

    // Effectivelly cheks the collision
    if (rayIntersectRec(a.rectangle.getCenter(), direction, expanded, results)) {
        if (results.contactTime >= 0.0 && results.contactTime < 1.0) {
            return true;
        }
    }
    
    return false;
}

//
//  Checks if a dynamic rectangle intersects other static rectangle
//

const recIntersectStatic = (a: RigidbodyComponent, b: RectangleComponent, deltaTime: number, results: CollisionResult) => {
    
    // Rejects if origin rectangles does not has velocity
    if (a.velocity.x == 0 && a.velocity.y == 0)
        return false;

    // Expanded target rectangle
    const expanded = new RectangleComponent(
        b.width + a.rectangle.width,
        b.height + a.rectangle.height,
        b.transform
    );

    // Direction vector of origin rectangle
    const direction = a.velocity.muls(deltaTime);

    // Effectivelly cheks the collision
    if (rayIntersectRec(a.rectangle.getCenter(), direction, expanded, results)) {
        if (results.contactTime >= 0.0 && results.contactTime < 1.0) {
            return true;
        }
    }
    
    return false;
}

export { rayIntersectRec, recIntersectRec, recIntersectStatic, CollisionResult };