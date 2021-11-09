import { Engine } from "./core/engine";
import { WSClient } from "./clients/websocket";

import { Application } from "pixi.js";
import { MAIN_BG_COLOR, ROOT_DIV_ID, WS_SERVER_HOST } from "./constants/constants";

// Jquery like query selector
const $ = (name: string) => {
    return document.querySelector(name) as HTMLElement;
};

// Root div to append engine's view
const ROOT = $(ROOT_DIV_ID);

const main = () => {

    // Creates PIXI application
    const app = new Application({
        resolution: devicePixelRatio,
        backgroundColor: MAIN_BG_COLOR,
        resizeTo: ROOT
    });

    // Start websocket client
    const wsClient = new WSClient(WS_SERVER_HOST);

    // Start engine itself
    const engine = new Engine(wsClient, app, ROOT);

    // Start the engine systems
    engine.start(() => {
        // Start the engine game loop
        engine.loop().then(() => {
                // Properly close the engine
                engine.close();
                console.log("Close");
            }
        );
    });

    console.log("Teste");
}

main();