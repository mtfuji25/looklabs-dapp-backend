"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Level = void 0;
var Ecs_1 = require("./Ecs/Core/Ecs");
var LayerStack_1 = require("./LayerStack");
var Level = /** @class */ (function () {
    function Level(context, name) {
        if (name === void 0) { name = "Default"; }
        this.name = name;
        this.context = context;
        // Creates current level systems instances
        this.ecs = new Ecs_1.ECS();
        this.layerStack = new LayerStack_1.LayerStack();
    }
    Level.prototype.runPendings = function (deltaTime) {
        // Update ECS systems
        this.ecs.onUpdate(deltaTime);
        // Update all level's layers
        this.layerStack.layers.map(function (layer) {
            layer.onUpdate(deltaTime);
        });
    };
    Level.prototype.closeSystems = function () {
        this.layerStack.destroy();
        this.ecs.destroy();
    };
    Level.prototype.getName = function () { return this.name; };
    return Level;
}());
exports.Level = Level;
;
