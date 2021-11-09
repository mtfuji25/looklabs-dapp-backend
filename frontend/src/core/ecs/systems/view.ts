
import { CONTAINER_DIM } from "../../../constants/constants";
import { BTNS } from "../../inputs/inputs";
import { EcsData, EngineContext } from "../../interfaces";

interface ViewProperties {
    zoom: number;
    lastZoom: number;
    offsetX: number;
    offsetY: number;
    lastX: number;
    lastY: number;
    pressed: boolean;
}

const viewProperties: ViewProperties = {
    zoom: 0.0,
    lastZoom: 0.0,
    offsetX: 0.0,
    offsetY: 0.0,
    lastX: 0.0,
    lastY: 0.0,
    pressed: false
}

const initSysUpdateView = (context: EngineContext) => {
    viewProperties.offsetY = context.app.view.height - CONTAINER_DIM;
    viewProperties.lastX = context.inputs.cursor.x;
    viewProperties.lastY = context.inputs.cursor.y;
    viewProperties.lastZoom = context.inputs.wheel;
}

const sysUpdateView = (data: EcsData, context: EngineContext, deltaTime: number): void => {
    let localOffX = 0.0;
    let localOffY = 0.0;

    if (context.inputs.btn[BTNS.LEFT]) {
        if (!viewProperties.pressed) {
            viewProperties.lastX = context.inputs.cursor.x;
            viewProperties.lastY = context.inputs.cursor.y;

            viewProperties.pressed = true;
        }
        localOffX = context.inputs.cursor.x - viewProperties.lastX;
        localOffY = context.inputs.cursor.y - viewProperties.lastY;

    } else {
        if (viewProperties.pressed) {
            viewProperties.offsetX += context.inputs.cursor.x - viewProperties.lastX;
            viewProperties.offsetY += context.inputs.cursor.y - viewProperties.lastY;
        }

        viewProperties.pressed = false;
    }

    viewProperties.zoom += context.inputs.wheel - viewProperties.lastZoom;
    viewProperties.lastZoom = context.inputs.wheel;

    if (viewProperties.zoom < -25.0) viewProperties.zoom = -25.0;
    if (viewProperties.zoom >  10.0) viewProperties.zoom =  10.0;

    data.transforms.map((transform) => {
        transform.zoom = viewProperties.zoom / 25.0;
        transform.offsetX = viewProperties.offsetX + localOffX;
        transform.offsetY = viewProperties.offsetY + localOffY;
    });
}

export { sysUpdateView, initSysUpdateView };