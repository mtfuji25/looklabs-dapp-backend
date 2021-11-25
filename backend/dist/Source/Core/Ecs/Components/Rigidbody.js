"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Rigidbody = void 0;
var Math_1 = require("../../../Utils/Math");
// Collisions imports
var Collisions_1 = require("../../../Utils/Collisions");
var Rigidbody = /** @class */ (function () {
    function Rigidbody(rectangle) {
        this.rectangle = rectangle;
        this.velocity = new Math_1.Vec2();
    }
    Rigidbody.prototype.colide = function (other, deltaTime) {
        var results = {
            contactPoint: new Math_1.Vec2(),
            contactNormal: new Math_1.Vec2(),
            contactTime: 0.0,
            intersect: false
        };
        results.intersect = (0, Collisions_1.recIntersectRec)(this, other, deltaTime, results);
        return results;
    };
    Rigidbody.prototype.colideStatic = function (other, deltaTime) {
        var results = {
            contactPoint: new Math_1.Vec2(),
            contactNormal: new Math_1.Vec2(),
            contactTime: 0.0,
            intersect: false
        };
        results.intersect = (0, Collisions_1.recIntersectStatic)(this, other, deltaTime, results);
        return results;
    };
    return Rigidbody;
}());
exports.Rigidbody = Rigidbody;
