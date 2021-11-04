"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Level = void 0;
var ecs_1 = require("./ecs/core/ecs");
var layer_stack_1 = require("./layer-stack");
var Level = /** @class */ (function () {
    function Level(name) {
        if (name === void 0) { name = "Default"; }
        this.name = name;
        this.ecs = new ecs_1.ECS();
        this.layerStack = new layer_stack_1.LayerStack();
    }
    Level.prototype.getName = function () { return this.name; };
    return Level;
}());
exports.Level = Level;
;
