import { Map } from "./map";
import { Enemy } from "./enemy";
import { View } from "./view";
import { addServerListener } from "../server/client";

let layers = [];

const initLayers = (app) => {
    // Connect layers to the stack
    layers.push(new View(app));
    layers.push(new Map(app));
    let enemyLayer = new Enemy(app);
    layers.push(enemyLayer);

    // Call onAttach method
    layers.forEach((layer) => {
        layer.onAttach();
    });
}

export { initLayers, layers };