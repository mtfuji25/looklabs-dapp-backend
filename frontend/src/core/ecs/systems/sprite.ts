import { CONTAINER_DIM } from "../../../constants/constants";
import { EcsData, EngineContext } from "../../interfaces";

const sysUpdateSpritePos = (data: EcsData, context: EngineContext, deltaTime: number): void => {
    // Iterates through all sprites in system
    data.sprites.forEach((sprite) => {
        if (true) {
            const centerFactorX = (sprite.transform.pos.x - (CONTAINER_DIM / 2.0)) / (CONTAINER_DIM / 2.0);
            const centerFactorY = (sprite.transform.pos.y - (CONTAINER_DIM / 2.0)) / (CONTAINER_DIM / 2.0);
            const fixFactorX = (sprite.transform.pos.x - (sprite.transform.pos.x * (1 - sprite.transform.zoom))) / 2.0;
            const fixFactorY = (sprite.transform.pos.y - (sprite.transform.pos.y * (1 - sprite.transform.zoom))) / 2.0;
            
            sprite.sprite.x = sprite.transform.pos.x + sprite.transform.offsetX - (fixFactorX * centerFactorX);
            sprite.sprite.y = sprite.transform.pos.y + sprite.transform.offsetY - (fixFactorY * centerFactorY);
            sprite.setScale(1.0 - sprite.transform.zoom, 1.0 - sprite.transform.zoom);
        } else {
            sprite.sprite.x = sprite.transform.pos.x;
            sprite.sprite.y = sprite.transform.pos.y;
        }
    });
};

export { sysUpdateSpritePos };