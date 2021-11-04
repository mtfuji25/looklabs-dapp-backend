"use strict";
var Vec2 = /** @class */ (function () {
    function Vec2(x, y) {
        if (x === void 0) { x = 0.0; }
        if (y === void 0) { y = 0.0; }
        this.x = x;
        this.y = y;
    }
    Vec2.prototype.add = function (ohter) {
        return new Vec2(this.x + ohter.x, this.y + ohter.y);
    };
    Vec2.prototype.adds = function (ohter) {
        return new Vec2(this.x + ohter, this.y + ohter);
    };
    Vec2.prototype.sub = function (ohter) {
        return new Vec2(this.x - ohter.x, this.y - ohter.y);
    };
    Vec2.prototype.subs = function (ohter) {
        return new Vec2(this.x - ohter, this.y - ohter);
    };
    Vec2.prototype.mul = function (ohter) {
        return new Vec2(this.x * ohter.x, this.y * ohter.y);
    };
    Vec2.prototype.muls = function (ohter) {
        return new Vec2(this.x * ohter, this.y * ohter);
    };
    Vec2.prototype.div = function (ohter) {
        return new Vec2(this.x / ohter.x, this.y / ohter.y);
    };
    Vec2.prototype.divs = function (ohter) {
        return new Vec2(this.x / ohter, this.y / ohter);
    };
    Vec2.prototype.equal = function (other) {
        return this.x == other.x && this.y == other.y;
    };
    Vec2.prototype.dot = function (ohter) {
        return this.x * ohter.x + this.y * ohter.y;
    };
    Vec2.prototype.length = function () {
        return Math.sqrt(this.dot(this));
    };
    Vec2.prototype.squareLength = function () {
        return this.dot(this);
    };
    Vec2.prototype.normalize = function () {
        return this.muls(1.0 / this.length());
    };
    return Vec2;
}());
var deg2rad = function (deg) {
    return deg * (Math.PI / 180.0);
};
var rad2deg = function (rad) {
    return rad * (180.0 / Math.PI);
};
var lerp = function (a, b, t) {
    return (1 - t) * a + t * b;
};
