import { CONTAINER_DIM } from "../../../constants/constants";
import { EcsData, EngineContext } from "../../interfaces";

const sysUpdateAnimSpritePos = (data: EcsData, context: EngineContext, deltaTime: number): void => {
    // Iterates through all animsprites in system
    data.animsprites.forEach((animsprite) => {
        if (animsprite.useView) {
            const centerFactorX = (animsprite.transform.pos.x - (CONTAINER_DIM / 2.0)) / (CONTAINER_DIM / 2.0);
            const centerFactorY = (animsprite.transform.pos.y - (CONTAINER_DIM / 2.0)) / (CONTAINER_DIM / 2.0);
            const fixFactorX = (animsprite.transform.pos.x - (animsprite.transform.pos.x * (1 - animsprite.transform.zoom))) / 2.0;
            const fixFactorY = (animsprite.transform.pos.y - (animsprite.transform.pos.y * (1 - animsprite.transform.zoom))) / 2.0;
            
            animsprite.sprite.x = animsprite.transform.pos.x + animsprite.transform.offsetX;
            animsprite.sprite.y = animsprite.transform.pos.y + animsprite.transform.offsetY;
            console.log("AnimXf: ", animsprite.sprite.x)
            console.log("AnimYf: ", animsprite.sprite.y)
            animsprite.setScale(1.0 - animsprite.transform.zoom, 1.0 - animsprite.transform.zoom);
        } else {
            animsprite.sprite.x = animsprite.transform.pos.x;
            animsprite.sprite.y = animsprite.transform.pos.y;
        }
    });
};

export { sysUpdateAnimSpritePos };