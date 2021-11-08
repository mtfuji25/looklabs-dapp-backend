"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.lerp = exports.rad2deg = exports.deg2rad = exports.Vec2 = void 0;
var Vec2 = /** @class */ (function () {
    function Vec2(x, y) {
        if (x === void 0) { x = 0.0; }
        if (y === void 0) { y = 0.0; }
        this.x = x;
        this.y = y;
    }
    Vec2.prototype.add = function (other) {
        return new Vec2(this.x + other.x, this.y + other.y);
    };
    Vec2.prototype.adds = function (other) {
        return new Vec2(this.x + other, this.y + other);
    };
    Vec2.prototype.sub = function (other) {
        return new Vec2(this.x - other.x, this.y - other.y);
    };
    Vec2.prototype.subs = function (other) {
        return new Vec2(this.x - other, this.y - other);
    };
    Vec2.prototype.mul = function (other) {
        return new Vec2(this.x * other.x, this.y * other.y);
    };
    Vec2.prototype.muls = function (other) {
        return new Vec2(this.x * other, this.y * other);
    };
    Vec2.prototype.div = function (other) {
        return new Vec2(this.x / other.x, this.y / other.y);
    };
    Vec2.prototype.divs = function (other) {
        return new Vec2(this.x / other, this.y / other);
    };
    Vec2.prototype.equal = function (other) {
        return (this.x == other.x && this.y == other.y);
    };
    Vec2.prototype.dot = function (other) {
        return this.x * other.x + this.y * other.y;
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
exports.Vec2 = Vec2;
var deg2rad = function (deg) {
    return deg * (Math.PI / 180.0);
};
exports.deg2rad = deg2rad;
var rad2deg = function (rad) {
    return rad * (180.0 / Math.PI);
};
exports.rad2deg = rad2deg;
var lerp = function (a, b, t) {
    return (1 - t) * a + t * b;
};
exports.lerp = lerp;
