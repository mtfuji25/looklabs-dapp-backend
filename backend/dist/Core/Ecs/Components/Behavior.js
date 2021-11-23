"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Behavior = void 0;
var Math_1 = require("../../../Utils/Math");
var Behavior = /** @class */ (function () {
    function Behavior(status, transform, rigidbody) {
        this.staticColide = false;
        this.staticNormal = new Math_1.Vec2();
        this.staticCenter = new Math_1.Vec2();
        // Nearby enemies
        this.inRange = [];
        // Attacking status
        this.refresh = 0.0;
        this.attacking = false;
        this.colliding = [];
        // Healing purpose
        this.healing = false;
        this.status = status;
        this.transform = transform;
        this.rigidbody = rigidbody;
    }
    return Behavior;
}());
exports.Behavior = Behavior;
