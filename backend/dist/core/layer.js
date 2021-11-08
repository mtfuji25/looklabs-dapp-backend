"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Layer = void 0;
var Layer = /** @class */ (function () {
    function Layer(name, ecs) {
        if (name === void 0) { name = "Default"; }
        this.name = name;
        this.ecs = ecs;
        this.self = this.ecs.createEntity();
    }
    Layer.prototype.getSelf = function () { return this.self; };
    Layer.prototype.getName = function () { return this.name; };
    return Layer;
}());
exports.Layer = Layer;
;
