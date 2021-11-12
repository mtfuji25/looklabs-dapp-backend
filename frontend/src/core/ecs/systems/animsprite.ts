import { EcsData, EngineContext } from "../../interfaces";

const sysUpdateAnimSpritePos = (data: EcsData, context: EngineContext, deltaTime: number): void => {
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

export { sysUpdateAnimSpritePos };