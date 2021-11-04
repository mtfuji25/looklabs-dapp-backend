"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Layer = void 0;
var Layer = /** @class */ (function () {
    function Layer(name) {
        if (name === void 0) { name = "Default"; }
        this.name = name;
    }
    Layer.prototype.getName = function () { return this.name; };
    return Layer;
}());
exports.Layer = Layer;
;
