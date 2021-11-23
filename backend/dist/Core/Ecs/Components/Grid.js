"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Grid = void 0;
// Math imports
var Math_1 = require("../../../Utils/Math");
// Components imports
var Rectangle_1 = require("./Rectangle");
var Transform_1 = require("./Transform");
var Grid = /** @class */ (function () {
    function Grid(width, height) {
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
    Grid.prototype.addDynamic = function (entity) {
        var transform = entity.getTransform();
        var rectangle = entity.getRectangle();
        // Changes coordinate sistem from ndc to normalized left-upper origin
        var position = transform.pos.adds(1.0).divs(2.0);
        position.y = 1 - position.y;
        // Find the correct index of entity in grid
        var index = new Math_1.Vec2(Math.floor(position.x / (this.intervalX / 2.0)), Math.floor(position.y / (this.intervalY / 2.0)));
        var index1 = new Math_1.Vec2(Math.floor((position.x - (rectangle.width / 2.0)) / (this.intervalX / 2.0)), Math.floor((position.y - (rectangle.height / 2.0)) / (this.intervalY / 2.0)));
        var index2 = new Math_1.Vec2(Math.floor((position.x + (rectangle.width / 2.0)) / (this.intervalX / 2.0)), Math.floor((position.y + (rectangle.height / 2.0)) / (this.intervalY / 2.0)));
        // If index gets out of bounds return
        if (index.x >= this.width || index.y >= this.height)
            return;
        this.dynamics.push({
            entity: entity,
            index: index,
            ocupations: [
                index1,
                new Math_1.Vec2(index2.x, index1.y),
                new Math_1.Vec2(index1.x, index2.y),
                index2
            ]
        });
    };
    Grid.prototype.removeDynamic = function (entity) {
        this.dynamics = this.dynamics.filter(function (dynamic) { return dynamic.entity !== entity; });
    };
    Grid.prototype.getDynamic = function (entity) {
        return this.dynamics.find(function (dynamic) { return dynamic.entity === entity; });
    };
    Grid.prototype.addStatic = function (x, y) {
        if (x < 0 || x >= this.width || y < 0 || y >= this.height)
            return;
        this.statics[y * this.width + x] = new Rectangle_1.Rectangle(this.intervalX, this.intervalY, new Transform_1.Transform(((x * this.intervalX + this.intervalX / 2.0)) - 1.0, 1.0 - ((y * this.intervalY + this.intervalY / 2.0))));
    };
    Grid.prototype.removeStatic = function (x, y) {
        this.statics[y * this.width + x] = null;
    };
    return Grid;
}());
exports.Grid = Grid;
;
