// Import ECS
import { ECS } from "../Core/Ecs";

// Systems imports
import { sys_UpdateTextPos } from "./Text";
import { sys_UpdateSpritePos } from "./Sprite";
import { sys_UpdateAnimSpritePos } from "./AnimSprite";

const startSystems = (ecs: ECS) => {

    ecs.pushContainerSystem(sys_UpdateTextPos);
    ecs.pushContainerSystem(sys_UpdateSpritePos);
    ecs.pushContainerSystem(sys_UpdateAnimSpritePos);

};

export { startSystems };