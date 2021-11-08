import { ECS } from "../core/ecs";
import { sysUpdateGrid } from "./grid";
import { sysDispatchCollisions, sysGridCollision } from "./gridcollision";
import { sysUpdatePos } from "./rigidbody";
import { sysUpdateStatus } from "./status";

const initiSystems = (ecs: ECS) => {
    // Check for dead players
    ecs.pushContainerSystem(sysUpdateStatus);

    // Update dynamic index of grid entities
    ecs.pushContainerSystem(sysUpdateGrid);
    
    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(sysGridCollision);

    // Update all components position
    ecs.pushContainerSystem(sysUpdatePos);

    // Dispatch all collisions after solve them
    ecs.pushContainerSystem(sysDispatchCollisions);
}

export { initiSystems };