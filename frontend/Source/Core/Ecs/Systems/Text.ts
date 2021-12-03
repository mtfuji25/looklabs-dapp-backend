import { EcsData } from "../Interfaces";

const sys_UpdateTextPos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all texts in system
    data.texts.forEach((text) => {
        if (text.refresh) {
            text.text.x = Math.floor(text.transform.pos.x);
            text.text.y = Math.floor(text.transform.pos.y);
            
            text.text.scale.x = text.transform.scale.x;
            text.text.scale.y = text.transform.scale.y;
        }
    });
};

export { sys_UpdateTextPos };