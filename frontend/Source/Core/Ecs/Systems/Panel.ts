import { EcsData } from "../Interfaces";

const sys_UpdatePanelPos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all sprites in system
    data.panels.forEach((panel) => {
        if (panel.refresh) {
            panel.sprite.x = Math.floor(panel.transform.pos.x);
            panel.sprite.y = Math.floor(panel.transform.pos.y);
    
            panel.sprite.scale.x = panel.transform.scale.x;
            panel.sprite.scale.y = panel.transform.scale.y;
        }
    });
};

export { sys_UpdatePanelPos };

