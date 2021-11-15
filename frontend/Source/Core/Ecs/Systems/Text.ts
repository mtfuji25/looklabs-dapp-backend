import { EcsData } from "../Interfaces";

const sys_UpdateTextPos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all texts in system
    data.texts.forEach((text) => {
        text.text.x = text.transform.pos.x;
        text.text.y = text.transform.pos.y;
    });
};

export { sys_UpdateTextPos };