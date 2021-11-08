"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Status = exports.Rigidbody = exports.Rectangle = exports.Grid = exports.Transform = exports.Entity = exports.ECS = void 0;
var grid_1 = require("../components/grid");
var rectangle_1 = require("../components/rectangle");
var rigidbody_1 = require("../components/rigidbody");
var status_1 = require("../components/status");
var transform_1 = require("../components/transform");
var systems_1 = require("../systems");
// Component bitmasks
var Transform = 0;
exports.Transform = Transform;
var Grid = 1;
exports.Grid = Grid;
var Rectangle = 2;
exports.Rectangle = Rectangle;
var Rigidbody = 4;
exports.Rigidbody = Rigidbody;
var Status = 8;
exports.Status = Status;
// Key of index in identification array
var EntityKey = 999;
var ECS = /** @class */ (function () {
    function ECS() {
        // Data containers
        this.grids = [];
        this.rectangles = [];
        this.rigidbodys = [];
        this.transforms = [];
        this.status = [];
        // Store all entities identifications and layouts
        this.entities = [];
        // Store all systems
        this.containerSystems = [];
        this.entitiesSystems = [];
        (0, systems_1.initiSystems)(this);
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
                status: _this.status
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
    ECS.prototype.deleteEntity = function (id, layout) {
        // Manually remove the transform component
        this.transforms.slice(id[Transform], 1);
        // Removes the rest of the components from the entity
        if (layout & Grid) {
            this.grids.slice(id[Grid], 1);
            layout &= (~Grid);
        }
        if (layout & Rectangle) {
            this.rectangles.slice(id[Rectangle], 1);
            layout &= (~Rectangle);
        }
        if (layout & Rigidbody) {
            this.rigidbodys.slice(id[Rigidbody], 1);
            layout &= (~Rigidbody);
        }
        // Status component
        if (layout & Status) {
            this.status.slice(id[Status], 1);
            layout &= (~Status);
        }
        // Remove the entity itself from the identification array
        this.entities.slice(id[EntityKey], 1);
    };
    ECS.prototype.createEntity = function (x, y) {
        if (x === void 0) { x = 0.0; }
        if (y === void 0) { y = 0.0; }
        var id = {};
        // All entities should have a transform component
        // The TransformID of entity is basically the index in the
        // array that return the component 
        id[Transform] = this.transforms.length;
        // Create and store a new transform component in the data
        // container
        this.transforms.push(new transform_1.TransformComponent(x, y));
        // Add current location of entity in identification array
        id[EntityKey] = this.entities.length;
        // Create the effective entity representation
        var entity = new Entity(this, id, Transform);
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
        var _this = this;
        if (layout === void 0) { layout = Transform; }
        this.getComponent = {
            // Transform component
            0: function () {
                return _this.ecs.transforms[_this.id[Transform]];
            },
            // Grid component
            1: function () {
                if (_this.layout & Grid)
                    return _this.ecs.grids[_this.id[Grid]];
                return null;
            },
            // Rectangle component
            2: function () {
                if (_this.layout & Rectangle)
                    return _this.ecs.rectangles[_this.id[Rectangle]];
                return null;
            },
            // Rigidbody component
            4: function () {
                if (_this.layout & Rigidbody)
                    return _this.ecs.rigidbodys[_this.id[Rigidbody]];
                return null;
            },
            // Status component
            8: function () {
                if (_this.layout & Status)
                    return _this.ecs.status[_this.id[Status]];
                return null;
            }
        };
        this.addComponent = {
            // Grid component
            1: function (width, height) {
                if (width === void 0) { width = 0.0; }
                if (height === void 0) { height = 0.0; }
                if (_this.layout & Grid)
                    return _this.ecs.grids[_this.id[Grid]];
                var grid = new grid_1.GridComponent(width, height);
                _this.id[Grid] = _this.ecs.grids.length;
                _this.layout |= Grid;
                _this.ecs.grids.push(grid);
                return grid;
            },
            // Rectangle component
            2: function (width, height) {
                if (width === void 0) { width = 0.0; }
                if (height === void 0) { height = 0.0; }
                if (_this.layout & Rectangle)
                    return _this.ecs.rectangles[_this.id[Rectangle]];
                var transform = _this.ecs.transforms[_this.id[Transform]];
                var rectangle = new rectangle_1.RectangleComponent(width, height, transform);
                _this.id[Rectangle] = _this.ecs.rectangles.length;
                _this.layout |= Rectangle;
                _this.ecs.rectangles.push(rectangle);
                return rectangle;
            },
            // Rigidbody component
            4: function () {
                if (_this.layout & Rigidbody)
                    return _this.ecs.rigidbodys[_this.id[Rigidbody]];
                if (_this.layout & Rectangle) {
                    var rectangle = _this.ecs.rectangles[_this.id[Rectangle]];
                    var rigidbody = new rigidbody_1.RigidbodyComponent(rectangle);
                    _this.id[Rigidbody] = _this.ecs.rigidbodys.length;
                    _this.layout |= Rigidbody;
                    _this.ecs.rigidbodys.push(rigidbody);
                    return rigidbody;
                }
                return null;
            },
            // Status component
            8: function (health, defense) {
                if (health === void 0) { health = 0.0; }
                if (defense === void 0) { defense = 0.0; }
                if (_this.layout & Status)
                    return _this.ecs.status[_this.id[Status]];
                var stats = new status_1.StatusComponent(health, defense);
                _this.id[Status] = _this.ecs.status.length;
                _this.layout |= Status;
                _this.ecs.status.push(stats);
                return stats;
            }
        };
        this.removeComponent = {
            // Grid component
            1: function () {
                if (_this.layout & Grid) {
                    _this.ecs.grids.slice(_this.id[Grid], 1);
                    _this.layout &= (~Grid);
                }
            },
            // Rectangle component
            2: function () {
                if (_this.layout & Rectangle) {
                    _this.ecs.rectangles.slice(_this.id[Rectangle], 1);
                    _this.layout &= (~Rectangle);
                }
            },
            // Rigidbody component
            4: function () {
                if (_this.layout & Rigidbody) {
                    _this.ecs.rigidbodys.slice(_this.id[Rigidbody], 1);
                    _this.layout &= (~Rigidbody);
                }
            },
            // Status component
            8: function () {
                if (_this.layout & Status) {
                    _this.ecs.status.slice(_this.id[Status], 1);
                    _this.layout &= (~Status);
                }
            },
        };
        this.ecs = ecs;
        this.id = id;
        this.layout = layout;
    }
    Entity.prototype.destroy = function () {
        this.ecs.deleteEntity(this.id, this.layout);
    };
    return Entity;
}());
exports.Entity = Entity;
;
