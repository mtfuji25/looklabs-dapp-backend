"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Rectangle = void 0;
// Utils
var Math_1 = require("../../../Utils/Math");
var Rectangle = /** @class */ (function () {
    function Rectangle(width, height, transform) {
        this.width = width;
        this.height = height;
        this.transform = transform;
    }
    Rectangle.prototype.getCenter = function () {
        return new Math_1.Vec2(this.transform.pos.x, this.transform.pos.y);
    };
    Rectangle.prototype.getLuCorner = function () {
        return new Math_1.Vec2(this.transform.pos.x - (this.width / 2.0), this.transform.pos.y + (this.height / 2.0));
    };
    Rectangle.prototype.getLdCorner = function () {
        return new Math_1.Vec2(this.transform.pos.x - (this.width / 2.0), this.transform.pos.y - (this.height / 2.0));
    };
    Rectangle.prototype.getRuCorner = function () {
        return new Math_1.Vec2(this.transform.pos.x + (this.width / 2.0), this.transform.pos.y + (this.height / 2.0));
    };
    Rectangle.prototype.getRdCorner = function () {
        return new Math_1.Vec2(this.transform.pos.x + (this.width / 2.0), this.transform.pos.y - (this.height / 2.0));
    };
    return Rectangle;
}());
exports.Rectangle = Rectangle;
