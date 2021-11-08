"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.sysUpdateGrid = void 0;
var math_1 = require("../../../utils/math");
var ecs_1 = require("../core/ecs");
var sysUpdateGrid = function (data, deltaTime) {
    // Iterates through all grids in system
    data.grids.forEach(function (grid) {
        // Just dynamics entitys should be checked
        grid.dynamics.forEach(function (dynamicEntity) {
            var transform = dynamicEntity.entity.getComponent[ecs_1.Transform]();
            // Changes coordinate sistem from ndc to normalized left-upper origin
            var position = transform.pos.adds(1.0).divs(2.0);
            position.y = 1 - position.y;
            // Find new index of entity
            var index = new math_1.Vec2(Math.floor(position.x / (grid.intervalX / 2.0)), Math.floor(position.y / (grid.intervalY / 2.0)));
            // Update the index in the definition
            dynamicEntity.index = index;
        });
    });
};
exports.sysUpdateGrid = sysUpdateGrid;
