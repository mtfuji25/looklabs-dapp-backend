import { PlayerLayer } from "./player";
import { BgLayer } from "./background";

let layers = [];

const initLayers = (app) => {
    // Connect layers to the stack
    layers.push(new BgLayer(app));
    layers.push(new PlayerLayer(app));

    // Call onAttach method
    layers.forEach((layer) => {
        layer.onAttach();
    });
}

export { initLayers, layers };