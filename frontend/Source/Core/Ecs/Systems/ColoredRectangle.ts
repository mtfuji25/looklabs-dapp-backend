import { EcsData } from "../Interfaces";

const sys_UpdateColoredRectangle = (data: EcsData, deltaTime: number): void => {
    // Iterates through all animsprites in system
    data.coloredRecs.forEach((rectangle) => {
        if (rectangle.refresh) {
            rectangle.sprite.x = rectangle.transform.pos.x;
            rectangle.sprite.y = rectangle.transform.pos.y;
    
            rectangle.sprite.scale.x = rectangle.transform.scale.x;
            rectangle.sprite.scale.y = rectangle.transform.scale.y;
        }
        rectangle.graphics.clear();

        rectangle.graphics.beginFill(rectangle.color);

        rectangle.graphics.drawRect(rectangle.sprite.x, rectangle.sprite.y, rectangle.width, rectangle.height);

        rectangle.graphics.endFill();
    });
};

export { sys_UpdateColoredRectangle };