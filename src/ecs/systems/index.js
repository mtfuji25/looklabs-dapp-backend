import { ECS_CORE } from "../core/ecs";
import { sysApplyGravity } from "./gravity";
import { sysUpdateVel, sysUpdatePos } from "./movements";

const initSystems = () => {
    ECS_CORE.registerSystem(sysApplyGravity, ECS_CORE.CONTAINER_SYS);
    ECS_CORE.registerSystem(sysUpdateVel, ECS_CORE.CONTAINER_SYS);
    ECS_CORE.registerSystem(sysUpdatePos, ECS_CORE.CONTAINER_SYS);
}

export { initSystems };