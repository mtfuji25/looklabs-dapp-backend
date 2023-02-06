import { Engine } from "./Core/Engine";

// Web clients imports
import { WSClient } from "./Clients/WebSocket";
import { StrapiClient } from "./Clients/Strapi";
import { MockedStrapi } from "./Clients/MockedStrapi";

// Pixi imports
import { Application } from "pixi.js";


// Sentry logging imports
import * as Sentry from "@sentry/browser";
// Importing @sentry/tracing patches the global hub for tracing to work.
import * as Tracing from "@sentry/tracing";

// Constants
import {
    MAIN_BG_COLOR,
    ROOT_DIV_ID,
    STRAPI_SERVER_HOST,
    STRAPI_BEARER_TOKEN,
    WS_HOST,
    WS_PORT,
    LOGGER_LEVEL
} from "./Constants/Constants";
import { Logger } from "./Utils/Logger";

// Jquery like query selector
const $ = (name: string) => {
    return document.querySelector(name) as HTMLElement;
};

// Root div to append engine's view
const ROOT = $(ROOT_DIV_ID);

const main = async () => {

    Sentry.init({
        dsn: "https://0310fb88d0254835be8a3d60b9a17bd6@o1091574.ingest.sentry.io/6108697",            
        // Set tracesSampleRate to 1.0 to capture 100%
        // of transactions for performance monitoring.
        // We recommend adjusting this value in production
        tracesSampleRate: 1.0,
    });

    Logger.start(LOGGER_LEVEL);

    // Creates PIXI application
    const app = new Application({
        resolution: devicePixelRatio,
        backgroundColor: MAIN_BG_COLOR,
        resizeTo: ROOT
    });

    // Creates websocket client
    const wsClient = new WSClient(WS_HOST, WS_PORT);

    // Creates strapi client
    // const strapiClient = new StrapiClient(STRAPI_SERVER_HOST, STRAPI_BEARER_TOKEN);
    const strapiClient = new MockedStrapi(STRAPI_SERVER_HOST, STRAPI_BEARER_TOKEN);

    // Start engine itself
    const engine = new Engine(wsClient, strapiClient, app, ROOT);
        
    await engine.start();

    await engine.loop();

    await engine.close();
};

main();
