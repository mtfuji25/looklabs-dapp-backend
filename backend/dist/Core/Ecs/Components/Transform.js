"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Transform = void 0;
var Math_1 = require("../../../Utils/Math");
var Transform = /** @class */ (function () {
    function Transform(x, y) {
        this.pos = new Math_1.Vec2(x, y);
        this.scale = new Math_1.Vec2(1.0, 1.0);
    }
    return Transform;
}());
exports.Transform = Transform;
