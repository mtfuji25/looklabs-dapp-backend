import { ECS } from "../core/ecs";
import { sysUpdateAnimSpritePos } from "./animsprite";
import { sysUpdateSpritePos } from "./sprite";
import { initSysUpdateView, sysUpdateView } from "./view";

const initiSystems = (ecs: ECS) => {
    ecs.pushContainerSystem(sysUpdateView)
    initSysUpdateView(ecs.context);

    ecs.pushContainerSystem(sysUpdateSpritePos);
    ecs.pushContainerSystem(sysUpdateAnimSpritePos);
}

export { initiSystems };