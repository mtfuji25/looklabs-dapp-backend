import { EcsData } from "../Interfaces";

const sys_UpdateAnimSpritePos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all animsprites in system
    data.animsprites.forEach((animsprite) => {
        animsprite.sprite.x = animsprite.transform.pos.x;
        animsprite.sprite.y = animsprite.transform.pos.y;

        animsprite.setScale(
            animsprite.transform.scale.x,
            animsprite.transform.scale.y,
        );
    });
};

export { sys_UpdateAnimSpritePos };