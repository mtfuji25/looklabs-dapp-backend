import { BaseMove } from "./base-move";
import { Map } from "./map";
import { Enemy } from "./enemy";
import { addServerListener } from "../server/client";

let layers = [];

const initLayers = (app) => {
    // Connect layers to the stack
    layers.push(new BaseMove(app));
    layers.push(new Map(app));
    let enemyLayer = new Enemy(app);
    layers.push(enemyLayer);
    addServerListener(enemyLayer);

    // Call onAttach method
    layers.forEach((layer) => {
        layer.onAttach();
    });
}

export { initLayers, layers };