import { ECS } from "../ecs/core/ecs";
import { BTNS, inputs } from "../inputs/inputs";

class View {
    constructor(app) {
        this.app = app;

        // View zoom of the app
        this.zoom = 0.0;
        this.lastZoom = 0.0;

        // Current offset from orgin
        this.xOffset = 0.0;
        this.yOffset = 0.0;

        // Used for calculus purpose
        this.lastX = 0.0;
        this.lastY = 0.0;

        // States
        this.pressed = false;
    }

    onAttach() {
        ECS.setGlobal("view", {
            zoom: this.zoom,
            xOffset: this.xOffset,
            yOffset: this.yOffset
        });
        this.lastX = inputs.cursor.x;
        this.lastY = inputs.cursor.y;
        this.lastZoom = inputs.wheel;
    }

    onUpdate(deltaTime) {
        let localOffX = 0.0;
        let localOffY = 0.0;

        if (inputs.btn[BTNS.LEFT]) {
            if (!this.pressed) {
                this.lastX = inputs.cursor.x;
                this.lastY = inputs.cursor.y;

                this.pressed = true;
            }
            localOffX = inputs.cursor.x - this.lastX;
            localOffY = inputs.cursor.y - this.lastY;

        } else {
            if (this.pressed) {
                this.xOffset += inputs.cursor.x - this.lastX;
                this.yOffset += inputs.cursor.y - this.lastY;
            }

            this.pressed = false;
        }

        this.zoom += inputs.wheel - this.lastZoom;
        this.lastZoom = inputs.wheel;

        if (this.zoom < -25.0) this.zoom = -25.0;
        if (this.zoom >  25.0) this.zoom =  10.0;

        ECS.setGlobal("view", {
            zoom: this.zoom / 25,
            xOffset: this.xOffset + localOffX,
            yOffset: this.yOffset + localOffY
        });
    }
}

export { View };