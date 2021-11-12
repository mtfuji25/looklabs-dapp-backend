import { ECS } from "../core/ecs";
import { sysUpdateAnimSpritePos } from "./animsprite";
import { sysUpdateSpritePos } from "./sprite";

const initiSystems = (ecs: ECS) => {
    ecs.pushContainerSystem(sysUpdateSpritePos);
    ecs.pushContainerSystem(sysUpdateAnimSpritePos);
}

export { initiSystems };