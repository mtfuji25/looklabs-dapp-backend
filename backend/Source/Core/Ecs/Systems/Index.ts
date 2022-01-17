// Import ECS
import { ECS } from "../Core/Ecs";

// Import systems
import { sys_UpdatePos } from "./Rigidbody";
import { sys_CheckCollisions, sys_UpdateGrid } from "./Grid";
import { sys_DipatchDeaths, sys_UpdateStatus } from "./Status";
import { sys_CheckForBerserker, sys_CheckInRange, sys_UpdateBehavior } from "./Behavior";
import { sys_UpdateCollisions } from "./Grid";
import { sys_CheckIndex, sys_CheckOverlap } from "./Aabb";

const startSystems = (ecs: ECS) => {
    // Update all status components
    ecs.pushContainerSystem(sys_UpdateStatus);

    // Dispatch all deaths
    ecs.pushContainerSystem(sys_DipatchDeaths);

    // Update dynamic index of grid entities
    ecs.pushContainerSystem(sys_UpdateGrid);

    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(sys_CheckCollisions);
    
    // Update Behavior requirements
    ecs.pushContainerSystem(sys_CheckForBerserker);

    // Update Behavior requirements
    ecs.pushContainerSystem(sys_CheckInRange);

    // Update Behavior tree
    ecs.pushContainerSystem(sys_UpdateBehavior);

    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(sys_UpdateCollisions);

    // Update all components position
    ecs.pushContainerSystem(sys_UpdatePos);

    // Update all components position
    ecs.pushContainerSystem(sys_CheckOverlap);

    // A temporary fix to invalid positions
    /*
    So far, this only affects one cell in the grid { x: 9, y: 34 }
    At the top left corner of the map where there's an odd corner
    */
    ecs.pushContainerSystem(sys_CheckIndex);
};




export { startSystems };