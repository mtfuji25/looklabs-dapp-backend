"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.MapColliderLayer = void 0;
var ecs_1 = require("../core/ecs/core/ecs");
var layer_1 = require("../core/layer");
var level_collider_json_1 = __importDefault(require("../assets/level_collider.json"));
var MapColliderLayer = /** @class */ (function (_super) {
    __extends(MapColliderLayer, _super);
    function MapColliderLayer(ecs) {
        var _this = _super.call(this, "TesteLayer", ecs) || this;
        _this.self.addComponent[ecs_1.Grid](level_collider_json_1.default["width"], level_collider_json_1.default["height"]);
        return _this;
    }
    MapColliderLayer.prototype.onAttach = function () {
        var grid = this.self.getComponent[ecs_1.Grid]();
        for (var i = 0; i < level_collider_json_1.default["width"]; ++i) {
            for (var j = 0; j < level_collider_json_1.default["height"]; ++j) {
                var collider = level_collider_json_1.default["data"][i][j];
                if (collider !== 0) {
                    grid.addStatic(j, i);
                }
            }
        }
    };
    MapColliderLayer.prototype.onUpdate = function (deltaTime) { };
    MapColliderLayer.prototype.onDetach = function () { };
    return MapColliderLayer;
}(layer_1.Layer));
exports.MapColliderLayer = MapColliderLayer;
