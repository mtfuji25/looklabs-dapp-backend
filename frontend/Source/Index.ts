import { Engine } from "./Core/Engine";

// Web clients imports
import { WSClient } from "./Clients/WebSocket";
import { StrapiClient } from "./Clients/Strapi";

// Pixi imports
import { Application } from "pixi.js";

// Constants
import {
    MAIN_BG_COLOR,
    ROOT_DIV_ID,
    STRAPI_SERVER_HOST,
    STRAPI_BEARER_TOKEN,
    WS_HOST
} from "./Constants/Constants";

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

    // Creates websocket client
    const wsClient = new WSClient(WS_HOST);

    // Creates strapi client
    const strapiClient = new StrapiClient(STRAPI_SERVER_HOST, STRAPI_BEARER_TOKEN);

    // Start engine itself
    const engine = new Engine(wsClient, strapiClient, app, ROOT);

    // Start the engine systems
    engine.start(() => {
        // Start the engine game loop
        engine.loop().then(() => {
            // Properly close the engine
            engine.close();
        });
    });
};

main();
