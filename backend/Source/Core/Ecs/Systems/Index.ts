// Import ECS
import { ECS } from "../Core/Ecs";

// Import systems
import { sys_UpdatePos } from "./Rigidbody";
import { sys_CheckCollisions, sys_UpdateGrid } from "./Grid";
import { sys_DipatchDeaths, sys_UpdateStatus } from "./Status";
import { sys_CheckInRange, sys_UpdateBehavior } from "./Behavior";
import { sys_UpdateCollisions } from "./Grid";
import { sys_CheckOverlap } from "./Aabb";

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
    // ecs.pushContainerSystem(sys_CheckForBerserker);

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
};

export { startSystems };