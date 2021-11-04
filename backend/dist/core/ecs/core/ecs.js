"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Rigidbody = exports.Rectangle = exports.Grid = exports.Transform = exports.Entity = exports.ECS = void 0;
var transform_1 = require("../components/transform");
// Component bitmasks
var Transform = 0;
exports.Transform = Transform;
var Grid = 1;
exports.Grid = Grid;
var Rectangle = 2;
exports.Rectangle = Rectangle;
var Rigidbody = 4;
exports.Rigidbody = Rigidbody;
var ECS = /** @class */ (function () {
    function ECS() {
        // Data containers
        this.grids = [];
        this.rectangles = [];
        this.rigidbodys = [];
        this.transforms = [];
    }
    // getComponent(id, layout): void {
    // }
    // removeComponent(id, layout): void {
    // }
    // addComponent(id, layout): void {
    // }
    // deleteEntity(id, layout): void {
    // }
    ECS.prototype.createEntity = function (x, y, layout) {
        if (x === void 0) { x = 0.0; }
        if (y === void 0) { y = 0.0; }
        if (layout === void 0) { layout = Transform; }
        var id = {};
        // All entities should have a transform component
        // The TransformID of entity is basically the index in the
        // array that return the component 
        id[Transform] = this.transforms.length;
        // Create and store a new transform component in the data
        // container
        this.transforms.push(new transform_1.TransformComponent(x, y));
    };
    return ECS;
}());
exports.ECS = ECS;
;
var Entity = /** @class */ (function () {
    function Entity(ecs, id, layout) {
        if (layout === void 0) { layout = Transform; }
        this.getComponent = {
            0: function () {
                console.log("teste");
            },
            1: function () {
                console.log("teste1");
            },
            2: function () {
                console.log("teste2");
            },
            4: function () {
                console.log("teste3");
            },
        };
        this.addComponent = {
            0: function () {
                console.log("teste");
            },
            1: function () {
                console.log("teste1");
            },
            2: function () {
                console.log("teste2");
            },
            4: function () {
                console.log("teste3");
            },
        };
        this.ecs = ecs;
        this.id = id;
        this.layout = layout;
    }
    Entity.prototype.destroy = function () {
    };
    return Entity;
}());
exports.Entity = Entity;
;
