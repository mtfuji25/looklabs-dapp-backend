"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Entity = exports.ECS = void 0;
// Math imports
var Math_1 = require("../../../Utils/Math");
// Components imports
var Grid_1 = require("../Components/Grid");
var Rectangle_1 = require("../Components/Rectangle");
var Rigidbody_1 = require("../Components/Rigidbody");
var Transform_1 = require("../Components/Transform");
// System index imports
var Index_1 = require("../Systems/Index");
// Component bitmasks
var masks = {
    transform: 0,
    grid: 1,
    rectangle: 2,
    rigidbody: 4,
};
// Key of index in identification array
var EntityKey = 999;
// Main ECS class
var ECS = /** @class */ (function () {
    function ECS() {
        // Data containers
        this.grids = [];
        this.rectangles = [];
        this.rigidbodys = [];
        this.transforms = [];
        // Store all entities identifications and layouts
        this.entities = [];
        // Store all systems
        this.containerSystems = [];
        this.entitiesSystems = [];
        (0, Index_1.startSystems)(this);
    }
    ECS.prototype.onUpdate = function (deltaTime) {
        var _this = this;
        // Update all container systems
        this.containerSystems.map(function (fn) {
            fn({
                grids: _this.grids,
                rectangles: _this.rectangles,
                rigidbodys: _this.rigidbodys,
                transforms: _this.transforms,
            }, deltaTime);
        });
        // Update all entities systems
        this.entitiesSystems.map(function (fn) {
            _this.entities.map(function (entity) {
                fn(entity, deltaTime);
            });
        });
    };
    ECS.prototype.pushContainerSystem = function (fn) {
        this.containerSystems.push(fn);
    };
    ECS.prototype.pushEntitySystem = function (fn) {
        this.entitiesSystems.push(fn);
    };
    ECS.prototype.destroy = function () {
        this.entities.map(function (entity) {
            entity.destroy();
        });
    };
    ECS.prototype.deleteEntity = function (entity) {
        // Manually remove the transform component
        this.transforms.slice(entity.id[masks.transform], 1);
        // Removes the rest of the components from the entity
        entity.remGrid();
        entity.remRectangle();
        entity.remRigidbody();
        // Remove the entity itself from the identification array
        this.entities.slice(entity.id[EntityKey], 1);
    };
    ECS.prototype.createEntity = function (x, y) {
        if (x === void 0) { x = 0.0; }
        if (y === void 0) { y = 0.0; }
        var id = {};
        // All entities should have a transform component
        // The TransformID of entity is basically the index in the
        // array that return the component 
        id[masks.transform] = this.transforms.length;
        // Create and store a new transform component in the data
        // container
        this.transforms.push(new Transform_1.Transform(x, y));
        // Add current location of entity in identification array
        id[EntityKey] = this.entities.length;
        // Create the effective entity representation
        var entity = new Entity(this, id, masks.transform);
        // Add it to the identification array
        this.entities.push(entity);
        return entity;
    };
    return ECS;
}());
exports.ECS = ECS;
;
var Entity = /** @class */ (function () {
    function Entity(ecs, id, layout) {
        this.ecs = ecs;
        this.id = id;
        this.layout = layout;
    }
    // Getters
    Entity.prototype.getTransform = function () {
        return this.ecs.transforms[this.id[masks.transform]];
    };
    Entity.prototype.getGrid = function () {
        if (this.layout & masks.grid)
            return this.ecs.grids[this.id[masks.grid]];
        return this.addGrid();
    };
    Entity.prototype.getRectangle = function () {
        if (this.layout & masks.rectangle)
            return this.ecs.rectangles[this.id[masks.rectangle]];
        return this.addRectangle();
    };
    Entity.prototype.getRigidbody = function () {
        if (this.layout & masks.rigidbody)
            return this.ecs.rigidbodys[this.id[masks.rigidbody]];
        return this.addRigidbody();
    };
    // Adders
    Entity.prototype.addGrid = function (width, height) {
        if (width === void 0) { width = 0.0; }
        if (height === void 0) { height = 0.0; }
        if (this.layout & masks.grid)
            return this.getGrid();
        var grid = new Grid_1.Grid(width, height);
        this.id[masks.grid] = this.ecs.grids.length;
        this.layout |= masks.grid;
        this.ecs.grids.push(grid);
        return grid;
    };
    Entity.prototype.addRectangle = function (width, height) {
        if (width === void 0) { width = 0.0; }
        if (height === void 0) { height = 0.0; }
        if (this.layout & masks.rectangle)
            return this.getRectangle();
        var rectangle = new Rectangle_1.Rectangle(width, height, this.getTransform());
        this.id[masks.rectangle] = this.ecs.rectangles.length;
        this.layout |= masks.rectangle;
        this.ecs.rectangles.push(rectangle);
        return rectangle;
    };
    Entity.prototype.addRigidbody = function (width, height, velocity) {
        if (width === void 0) { width = 0.0; }
        if (height === void 0) { height = 0.0; }
        if (velocity === void 0) { velocity = new Math_1.Vec2(); }
        if (this.layout & masks.rigidbody)
            return this.getRigidbody();
        var rigidbody;
        if (this.layout & masks.rectangle) {
            var rectangle = this.getRectangle();
            rigidbody = new Rigidbody_1.Rigidbody(rectangle);
        }
        else {
            var rectangle = this.addRectangle(width, height);
            rigidbody = new Rigidbody_1.Rigidbody(rectangle);
        }
        this.id[masks.rigidbody] = this.ecs.rigidbodys.length;
        this.layout |= masks.rigidbody;
        this.ecs.rigidbodys.push(rigidbody);
        return rigidbody;
    };
    // Removers
    Entity.prototype.remGrid = function () {
        if (this.layout & masks.grid) {
            this.ecs.grids.slice(this.id[masks.grid], 1);
            this.layout &= (~masks.grid);
        }
    };
    Entity.prototype.remRectangle = function () {
        if (this.layout & masks.rectangle) {
            this.ecs.rectangles.slice(this.id[masks.rectangle], 1);
            this.layout &= (~masks.rectangle);
        }
    };
    Entity.prototype.remRigidbody = function () {
        if (this.layout & masks.rigidbody) {
            this.ecs.rigidbodys.slice(this.id[masks.rigidbody], 1);
            this.layout &= (~masks.rigidbody);
        }
    };
    Entity.prototype.destroy = function () {
        this.ecs.deleteEntity(this);
    };
    return Entity;
}());
exports.Entity = Entity;
;
