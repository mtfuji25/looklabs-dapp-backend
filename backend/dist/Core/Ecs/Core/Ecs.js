"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Entity = exports.ECS = void 0;
// Math imports
var Math_1 = require("../../../Utils/Math");
// Components imports
var Grid_1 = require("../Components/Grid");
var Status_1 = require("../Components/Status");
var Behavior_1 = require("../Components/Behavior");
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
    status: 8,
    behavior: 16,
};
// Key of index in identification array
var EntityKey = 999;
// Main ECS class
var ECS = /** @class */ (function () {
    function ECS() {
        this.gridId = 0;
        this.statusId = 0;
        this.behaviorId = 0;
        this.rectangleId = 0;
        this.rigidbodyId = 0;
        this.transformId = 0;
        this.entitiesId = 0;
        // Data containers
        this.grids = {};
        this.status = {};
        this.behaviors = {};
        this.rectangles = {};
        this.rigidbodys = {};
        this.transforms = {};
        // Store all entities identifications and layouts
        this.entities = {};
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
                grids: Object.values(_this.grids),
                status: Object.values(_this.status),
                behaviors: Object.values(_this.behaviors),
                rectangles: Object.values(_this.rectangles),
                rigidbodys: Object.values(_this.rigidbodys),
                transforms: Object.values(_this.transforms),
            }, deltaTime);
        });
        // Update all entities systems
        this.entitiesSystems.map(function (fn) {
            Object.values(_this.entities).map(function (entity) {
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
        Object.values(this.entities).map(function (entity) {
            entity.destroy();
        });
    };
    ECS.prototype.deleteEntity = function (id) {
        var entity = this.entities[id[EntityKey]];
        // Manually remove the transform component
        delete this.transforms[id[masks.transform]];
        // Removes the rest of the components from the entity
        entity.remGrid();
        entity.remRectangle();
        entity.remStatus();
        entity.remRigidbody();
        entity.remBehavior();
        // Remove the entity itself from the identification array
        delete this.entities[id[EntityKey]];
    };
    ECS.prototype.createEntity = function (x, y, name) {
        if (x === void 0) { x = 0.0; }
        if (y === void 0) { y = 0.0; }
        if (name === void 0) { name = ""; }
        var id = {};
        // All entities should have a transform component
        // The TransformID of entity is basically the index in the
        // array that return the component 
        id[masks.transform] = this.transformId;
        this.transformId++;
        // Create and store a new transform component in the data
        // container
        this.transforms[id[masks.transform]] = new Transform_1.Transform(x, y);
        // Add current location of entity in identification array
        id[EntityKey] = this.entitiesId;
        this.entitiesId++;
        // Create the effective entity representation
        var entity = new Entity(this, id, 0, name);
        // Add it to the identification array
        this.entities[id[EntityKey]] = entity;
        return entity;
    };
    return ECS;
}());
exports.ECS = ECS;
;
var Entity = /** @class */ (function () {
    function Entity(ecs, id, layout, name) {
        // Destroyed mark
        this.destroyed = false;
        this.ecs = ecs;
        this.id = id;
        this.layout = layout;
        this.name = name;
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
    Entity.prototype.getStatus = function () {
        if (this.layout & masks.status)
            return this.ecs.status[this.id[masks.status]];
        return this.addStatus();
    };
    Entity.prototype.getBehavior = function () {
        if (this.layout & masks.behavior)
            return this.ecs.behaviors[this.id[masks.behavior]];
        return this.addBehavior();
    };
    // Adders
    Entity.prototype.addGrid = function (width, height) {
        if (width === void 0) { width = 0.0; }
        if (height === void 0) { height = 0.0; }
        if (this.layout & masks.grid)
            return this.getGrid();
        var grid = new Grid_1.Grid(width, height);
        this.id[masks.grid] = this.ecs.gridId;
        this.ecs.gridId++;
        this.layout |= masks.grid;
        this.ecs.grids[this.id[masks.grid]] = grid;
        return grid;
    };
    Entity.prototype.addRectangle = function (width, height) {
        if (width === void 0) { width = 0.0; }
        if (height === void 0) { height = 0.0; }
        if (this.layout & masks.rectangle)
            return this.getRectangle();
        var rectangle = new Rectangle_1.Rectangle(width, height, this.getTransform());
        this.id[masks.rectangle] = this.ecs.rectangleId;
        this.ecs.rectangleId++;
        this.layout |= masks.rectangle;
        this.ecs.rectangles[this.id[masks.rectangle]] = rectangle;
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
        rigidbody.velocity = velocity;
        this.id[masks.rigidbody] = this.ecs.rigidbodyId;
        this.ecs.rigidbodyId++;
        this.layout |= masks.rigidbody;
        this.ecs.rigidbodys[this.id[masks.rigidbody]] = rigidbody;
        return rigidbody;
    };
    Entity.prototype.addStatus = function (attack, speed, health, defense, cooldown, name) {
        if (attack === void 0) { attack = 0.0; }
        if (speed === void 0) { speed = 0.0; }
        if (health === void 0) { health = 0.0; }
        if (defense === void 0) { defense = 0.0; }
        if (cooldown === void 0) { cooldown = 0.0; }
        if (name === void 0) { name = ""; }
        if (this.layout & masks.status)
            return this.getStatus();
        var status = new Status_1.Status(attack, speed, health, defense, cooldown, name);
        this.id[masks.status] = this.ecs.statusId;
        this.ecs.statusId++;
        this.layout |= masks.status;
        this.ecs.status[this.id[masks.status]] = status;
        return status;
    };
    Entity.prototype.addBehavior = function () {
        if (this.layout & masks.behavior)
            return this.getBehavior();
        var behavior;
        if (this.layout & masks.rigidbody) {
            if (this.layout & masks.status) {
                behavior = new Behavior_1.Behavior(this.getStatus(), this.getTransform(), this.getRigidbody());
            }
            else {
                var status = this.addStatus();
                behavior = new Behavior_1.Behavior(status, this.getTransform(), this.getRigidbody());
            }
        }
        else {
            if (this.layout & masks.status) {
                var rigidbody = this.addRigidbody();
                behavior = new Behavior_1.Behavior(this.getStatus(), this.getTransform(), rigidbody);
            }
            else {
                var status = this.addStatus();
                var rigidbody = this.addRigidbody();
                behavior = new Behavior_1.Behavior(status, this.getTransform(), rigidbody);
            }
        }
        this.id[masks.behavior] = this.ecs.behaviorId;
        this.ecs.behaviorId++;
        this.layout |= masks.behavior;
        this.ecs.behaviors[this.id[masks.behavior]] = behavior;
        return behavior;
    };
    // Removers
    Entity.prototype.remGrid = function () {
        if (this.layout & masks.grid) {
            delete this.ecs.grids[this.id[masks.grid]];
            this.layout &= (~masks.grid);
        }
    };
    Entity.prototype.remRectangle = function () {
        if (this.layout & masks.rectangle) {
            delete this.ecs.rectangles[this.id[masks.rectangle]];
            this.layout &= (~masks.rectangle);
        }
    };
    Entity.prototype.remRigidbody = function () {
        if (this.layout & masks.rigidbody) {
            delete this.ecs.rigidbodys[this.id[masks.rigidbody]];
            this.layout &= (~masks.rigidbody);
        }
    };
    Entity.prototype.remStatus = function () {
        if (this.layout & masks.status) {
            delete this.ecs.status[this.id[masks.status]];
            this.layout &= (~masks.status);
        }
    };
    Entity.prototype.remBehavior = function () {
        if (this.layout & masks.behavior) {
            delete this.ecs.behaviors[this.id[masks.behavior]];
            this.layout &= (~masks.behavior);
        }
    };
    Entity.prototype.destroy = function () {
        this.destroyed = true;
        this.ecs.deleteEntity(this.id);
    };
    return Entity;
}());
exports.Entity = Entity;
;
