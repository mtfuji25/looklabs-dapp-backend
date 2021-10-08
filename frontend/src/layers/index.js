import { View } from "./view";
import { BaseMap } from "./basemap";
import { Enemy } from "./enemy";
import { WS } from "../server/client";

let layers = [];

const initLayers = (app) => {
    // Connect layers to the stack

    // First connect view and map layers
    layers.push(new View(app, WS));
    layers.push(new BaseMap(app, WS));

    // Other layers
    layers.push(new Enemy(app, WS));


    // Call onAttach method
    layers.forEach((layer) => {
        layer.onAttach();
    });
}

export { initLayers, layers };