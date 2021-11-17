"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.startSystems = void 0;
// Import systems
var Rigidbody_1 = require("./Rigidbody");
var Grid_1 = require("./Grid");
var Status_1 = require("./Status");
var Behavior_1 = require("./Behavior");
var Grid_2 = require("./Grid");
var startSystems = function (ecs) {
    // Update all status components
    ecs.pushContainerSystem(Status_1.sys_UpdateStatus);
    // Dispatch all deaths
    ecs.pushContainerSystem(Status_1.sys_DipatchDeaths);
    // Update dynamic index of grid entities
    ecs.pushContainerSystem(Grid_1.sys_UpdateGrid);
    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(Grid_1.sys_CheckCollisions);
    // Update Behavior requirements
    ecs.pushContainerSystem(Behavior_1.sys_CheckInRange);
    // Update Behavior tree
    ecs.pushContainerSystem(Behavior_1.sys_UpdateBehavior);
    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(Grid_2.sys_UpdateCollisions);
    // Update all components position
    ecs.pushContainerSystem(Rigidbody_1.sys_UpdatePos);
};
exports.startSystems = startSystems;
