import { EcsData } from "../Interfaces";

const sys_UpdateSpritePos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all sprites in system
    data.sprites.forEach((sprite) => {
        if (sprite.refresh) {
            sprite.sprite.x = Math.floor(sprite.transform.pos.x);
            sprite.sprite.y = Math.floor(sprite.transform.pos.y);
    
            sprite.sprite.scale.x = sprite.transform.scale.x;
            sprite.sprite.scale.y = sprite.transform.scale.y;
        }
    });
};

export { sys_UpdateSpritePos };

