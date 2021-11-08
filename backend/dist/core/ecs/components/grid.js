"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.GridComponent = void 0;
var math_1 = require("../../../utils/math");
var ecs_1 = require("../core/ecs");
var rectangle_1 = require("./rectangle");
var transform_1 = require("./transform");
var GridComponent = /** @class */ (function () {
    function GridComponent(width, height) {
        if (width === void 0) { width = 0; }
        if (height === void 0) { height = 0; }
        // Stores all statics entities
        this.statics = [];
        // Stores all dynamic entities
        this.dynamics = [];
        this.width = width;
        this.height = height;
        // Get current single cell size
        this.intervalX = 2.0 / this.width;
        this.intervalY = 2.0 / this.height;
        // First initialize all static cells as false
        this.statics = new Array(this.width * this.height);
    }
    GridComponent.prototype.addDynamic = function (entity) {
        var transform = entity.getComponent[ecs_1.Transform]();
        // Changes coordinate sistem from ndc to normalized left-upper origin
        var position = transform.pos.adds(1.0).divs(2.0);
        position.y = 1 - position.y;
        // Find the correct index of entity in grid
        var index = new math_1.Vec2(Math.floor(position.x / (this.intervalX / 2.0)), Math.floor(position.y / (this.intervalY / 2.0)));
        // If index gets out of bounds return
        if (index.x >= this.width || index.y >= this.height)
            return;
        this.dynamics.push({ entity: entity, index: index });
    };
    GridComponent.prototype.removeDynamic = function (entity) {
        this.dynamics = this.dynamics.filter(function (dynamic) { return dynamic.entity !== entity; });
    };
    GridComponent.prototype.addStatic = function (x, y) {
        if (x < 0 || x >= this.width || y < 0 || y >= this.height)
            return;
        this.statics[y * this.width + x] = new rectangle_1.RectangleComponent(this.intervalX, this.intervalY, new transform_1.TransformComponent(((x * this.intervalX + this.intervalX / 2.0)) - 1.0, 1.0 - ((y * this.intervalY + this.intervalY / 2.0))));
    };
    GridComponent.prototype.removeStatic = function (x, y) {
        this.statics[y * this.width + x] = null;
    };
    return GridComponent;
}());
exports.GridComponent = GridComponent;
;
