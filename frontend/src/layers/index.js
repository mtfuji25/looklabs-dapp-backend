import { BaseMove } from "./base-move";
import { Map } from "./map";
import { Enemy } from "./enemy";

let layers = [];

const initLayers = (app) => {
    // Connect layers to the stack
    layers.push(new BaseMove(app));
    layers.push(new Map(app));
    layers.push(new Enemy(app));

    // Call onAttach method
    layers.forEach((layer) => {
        layer.onAttach();
    });
}

export { initLayers, layers };