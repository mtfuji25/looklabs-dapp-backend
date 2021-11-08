"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TransformComponent = void 0;
var math_1 = require("../../../utils/math");
var TransformComponent = /** @class */ (function () {
    function TransformComponent(x, y) {
        this.pos = new math_1.Vec2(x, y);
        this.scale = new math_1.Vec2(1.0, 1.0);
    }
    return TransformComponent;
}());
exports.TransformComponent = TransformComponent;
