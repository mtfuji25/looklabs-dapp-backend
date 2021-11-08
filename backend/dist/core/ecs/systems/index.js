"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.initiSystems = void 0;
var grid_1 = require("./grid");
var gridcollision_1 = require("./gridcollision");
var rigidbody_1 = require("./rigidbody");
var status_1 = require("./status");
var initiSystems = function (ecs) {
    // Check for dead players
    ecs.pushContainerSystem(status_1.sysUpdateStatus);
    // Update dynamic index of grid entities
    ecs.pushContainerSystem(grid_1.sysUpdateGrid);
    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(gridcollision_1.sysGridCollision);
    // Update all components position
    ecs.pushContainerSystem(rigidbody_1.sysUpdatePos);
    // Dispatch all collisions after solve them
    ecs.pushContainerSystem(gridcollision_1.sysDispatchCollisions);
};
exports.initiSystems = initiSystems;
