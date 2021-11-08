"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RigidbodyComponent = void 0;
var collision_1 = require("../../../utils/collision");
var math_1 = require("../../../utils/math");
var RigidbodyComponent = /** @class */ (function () {
    function RigidbodyComponent(rectangle) {
        this.onCollision = function (a, b) { };
        this.rectangle = rectangle;
        this.velocity = new math_1.Vec2();
    }
    RigidbodyComponent.prototype.colide = function (other, deltaTime) {
        var results = {
            contactPoint: new math_1.Vec2(),
            contactNormal: new math_1.Vec2(),
            contactTime: 0.0,
            intersect: false
        };
        results.intersect = (0, collision_1.recIntersectRec)(this, other, deltaTime, results);
        return results;
    };
    RigidbodyComponent.prototype.colideStatic = function (other, deltaTime) {
        var results = {
            contactPoint: new math_1.Vec2(),
            contactNormal: new math_1.Vec2(),
            contactTime: 0.0,
            intersect: false
        };
        results.intersect = (0, collision_1.recIntersectStatic)(this, other, deltaTime, results);
        return results;
    };
    return RigidbodyComponent;
}());
exports.RigidbodyComponent = RigidbodyComponent;
