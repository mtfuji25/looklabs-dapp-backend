"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RectangleComponent = void 0;
var math_1 = require("../../../utils/math");
var RectangleComponent = /** @class */ (function () {
    function RectangleComponent(width, height, transform) {
        this.width = width;
        this.height = height;
        this.transform = transform;
    }
    RectangleComponent.prototype.getCenter = function () {
        return new math_1.Vec2(this.transform.pos.x, this.transform.pos.y);
    };
    RectangleComponent.prototype.getLuCorner = function () {
        return new math_1.Vec2(this.transform.pos.x - (this.width / 2.0), this.transform.pos.y + (this.height / 2.0));
    };
    RectangleComponent.prototype.getLdCorner = function () {
        return new math_1.Vec2(this.transform.pos.x - (this.width / 2.0), this.transform.pos.y - (this.height / 2.0));
    };
    RectangleComponent.prototype.getRuCorner = function () {
        return new math_1.Vec2(this.transform.pos.x + (this.width / 2.0), this.transform.pos.y + (this.height / 2.0));
    };
    RectangleComponent.prototype.getRdCorner = function () {
        return new math_1.Vec2(this.transform.pos.x + (this.width / 2.0), this.transform.pos.y - (this.height / 2.0));
    };
    return RectangleComponent;
}());
exports.RectangleComponent = RectangleComponent;
