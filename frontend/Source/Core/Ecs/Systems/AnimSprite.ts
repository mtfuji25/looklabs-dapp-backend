import { EcsData } from "../Interfaces";

const sys_UpdateAnimSpritePos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all animsprites in system
    data.animsprites.forEach((animsprite) => {
        if (animsprite.refresh) {
            animsprite.sprite.x = Math.floor(animsprite.transform.pos.x);
            animsprite.sprite.y = Math.floor(animsprite.transform.pos.y);
    
            animsprite.sprite.scale.x = animsprite.transform.scale.x;
            animsprite.sprite.scale.y = animsprite.transform.scale.y;
        }
    });
};

export { sys_UpdateAnimSpritePos };