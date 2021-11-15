// Import ECS
import { ECS } from "../Core/Ecs";

// Import systems
import { sys_UpdateGrid } from "./Grid";
import { sys_UpdateCollisions } from "./Grid";

import { sys_UpdatePos } from "./Rigidbody";

const startSystems = (ecs: ECS) => {
    // Update dynamic index of grid entities
    ecs.pushContainerSystem(sys_UpdateGrid);
    
    // Colide and fix all velocitys in grid
    ecs.pushContainerSystem(sys_UpdateCollisions);

    // Update all components position
    ecs.pushContainerSystem(sys_UpdatePos);
};

export { startSystems };