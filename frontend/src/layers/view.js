import { ECS } from "../ecs/core/ecs";

import resources from "../resource.json";
import level from "../level.json";
import { BTNS, inputs } from "../inputs/inputs";

class View {
    constructor(app) {
        this.app = app;
        this.zoom = 1.0;
        this.xOffset = 0.0;
        this.yOffset = 0.0;
        this.lastX = 0.0;
        this.lastY = 0.0;
    }

    onAttach() {
        ECS.setGlobal("view-zoom", {
            zoom: this.zoom,
            xOffset: this.xOffset,
            yOffset: this.yOffset
        });
        this.lastX = inputs.cursor.x;
        this.lastY = inputs.cursor.y;
    }

    onUpdate(deltaTime) {
        if (inputs.btn[BTNS.MIDDLE]) {

        }
        
    }
}

export { View };