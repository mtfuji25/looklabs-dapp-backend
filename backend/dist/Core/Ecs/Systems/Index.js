"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.startSystems = void 0;
// Import systems
var Grid_1 = require("./Grid");
var Grid_2 = require("./Grid");
var Rigidbody_1 = require("./Rigidbody");
var startSystems = function (ecs) {
    // Update dynamic index of grid entities
    ecs.pushContainerSystem(Grid_1.sys_UpdateGrid);
    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(Grid_2.sys_UpdateCollisions);
    // Update all components position
    ecs.pushContainerSystem(Rigidbody_1.sys_UpdatePos);
};
exports.startSystems = startSystems;
