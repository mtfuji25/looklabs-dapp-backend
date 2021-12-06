import { Engine } from "./Core/Engine";
import { WSClient } from "./Clients/WebSocket";
import { StrapiClient } from "./Clients/Strapi";

import * as dotenv from "dotenv";
dotenv.config();

const STRAPI_SERVER_HOST = String(process.env.STRAPI_SERVER_HOST);
const STRAPI_BEARER_TOKEN = String(process.env.STRAPI_BEARER_TOKEN);

// const EXPRESS_PORT = Number(process.env.EXPRESS_SERVER_PORT);
const WS_PORT = Number(process.env.WS_SERVER_PORT);
const WS_HOST = String(process.env.WS_SERVER_HOST);

const main = async () => {
    // Start strapi client
    const strapiClient = new StrapiClient(STRAPI_SERVER_HOST, STRAPI_BEARER_TOKEN);

    // Start websocket client
    const wsClient = new WSClient(WS_HOST, WS_PORT);

    const engine = new Engine(wsClient, strapiClient);

    // Start the engine systems
    engine.start();

    // Start the engine game loop
    await engine.loop();

    // Properly close the engine
    engine.close();
};

main();
