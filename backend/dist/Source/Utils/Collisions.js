"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.recIntersectStatic = exports.recIntersectRec = exports.rayIntersectRec = void 0;
// Math imports
var Math_1 = require("./Math");
// Components imports
var Rectangle_1 = require("../Core/Ecs/Components/Rectangle");
//
//  Checks if a ray intersects one given rectangle
//
var rayIntersectRec = function (rayOrigin, rayDir, recTarget, results) {
    var _a, _b;
    var lu = recTarget.getLuCorner();
    var rd = recTarget.getRdCorner();
    var invdir = new Math_1.Vec2(1.0 / rayDir.x, 1.0 / rayDir.y);
    var tNear = new Math_1.Vec2((lu.x - rayOrigin.x) * invdir.x, (lu.y - rayOrigin.y) * invdir.y);
    if (tNear.x == NaN || tNear.y == NaN)
        return false;
    var tFar = new Math_1.Vec2((rd.x - rayOrigin.x) * invdir.x, (rd.y - rayOrigin.y) * invdir.y);
    if (tFar.x == NaN || tFar.y == NaN)
        return false;
    if (tNear.x > tFar.x)
        _a = [tFar.x, tNear.x], tNear.x = _a[0], tFar.x = _a[1];
    if (tNear.y > tFar.y)
        _b = [tFar.y, tNear.y], tNear.y = _b[0], tFar.y = _b[1];
    if (tNear.x > tFar.y || tNear.y > tFar.x)
        return false;
    var tHitNear = Math.max(tNear.x, tNear.y);
    var tHitFar = Math.min(tFar.x, tFar.y);
    if (tHitFar < 0)
        return false;
    results.contactTime = tHitNear;
    results.contactPoint.x = rayOrigin.x + tHitNear * rayDir.x;
    results.contactPoint.y = rayOrigin.y + tHitNear * rayDir.y;
    if (tNear.x > tNear.y) {
        if (invdir.x < 0) {
            results.contactNormal.x = 1;
            results.contactNormal.y = 0;
        }
        else {
            results.contactNormal.x = -1;
            results.contactNormal.y = 0;
        }
    }
    else if (tNear.x < tNear.y) {
        if (invdir.y < 0) {
            results.contactNormal.x = 0;
            results.contactNormal.y = 1;
        }
        else {
            results.contactNormal.x = 0;
            results.contactNormal.y = -1;
        }
    }
    return true;
};
exports.rayIntersectRec = rayIntersectRec;
//
//  Checks if a dynamic rectangle intersects other dynamic rectangle
//
var recIntersectRec = function (a, b, deltaTime, results) {
    // Rejects if origin rectangles does not has velocity
    if (a.velocity.x == 0 && a.velocity.y == 0)
        return false;
    // Expanded target rectangle
    var expanded = new Rectangle_1.Rectangle(b.rectangle.width + a.rectangle.width, b.rectangle.height + a.rectangle.height, b.rectangle.transform);
    // Direction vector of origin rectangle
    var direction = a.velocity.sub(b.velocity).muls(deltaTime);
    // Effectivelly cheks the collision
    if (rayIntersectRec(a.rectangle.getCenter(), direction, expanded, results)) {
        if (results.contactTime >= 0.0 && results.contactTime < 1.0) {
            return true;
        }
    }
    return false;
};
exports.recIntersectRec = recIntersectRec;
//
//  Checks if a dynamic rectangle intersects other static rectangle
//
var recIntersectStatic = function (a, b, deltaTime, results) {
    // Rejects if origin rectangles does not has velocity
    if (a.velocity.x == 0 && a.velocity.y == 0)
        return false;
    // Expanded target rectangle
    var expanded = new Rectangle_1.Rectangle(b.width + a.rectangle.width, b.height + a.rectangle.height, b.transform);
    // Direction vector of origin rectangle
    var direction = a.velocity.muls(deltaTime);
    // Effectivelly cheks the collision
    if (rayIntersectRec(a.rectangle.getCenter(), direction, expanded, results)) {
        if (results.contactTime >= 0.0 && results.contactTime < 1.0) {
            return true;
        }
    }
    return false;
};
exports.recIntersectStatic = recIntersectStatic;
