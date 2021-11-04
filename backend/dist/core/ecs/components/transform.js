"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.TransformComponent = void 0;
var TransformComponent = /** @class */ (function () {
    function TransformComponent(x, y) {
        this.pos = new Vec2(x, y);
        this.scale = new Vec2(1.0, 1.0);
    }
    return TransformComponent;
}());
exports.TransformComponent = TransformComponent;
