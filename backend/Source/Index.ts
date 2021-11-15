// Core engine import
import { Engine } from "./Core/Engine";

// Web clients import
import { WSClient } from "./Clients/WebSocket";
import { StrapiClient } from "./Clients/Strapi";

import * as dotenv from "dotenv";
dotenv.config();

// WebSocket Server configs
const WS_HOST = String(process.env.WS_SERVER_HOST);
const WS_PORT = Number(process.env.WS_SERVER_PORT);

// Strapi Server configs
const STRAPI_HOST = String(process.env.STRAPI_SERVER_HOST);
const STRAPI_PORT = Number(process.env.STRAPI_SERVER_PORT);

// Express Server configs
const EXPRESS_HOST = String(process.env.EXPRESS_SERVER_HOST);
const EXPRESS_PORT = Number(process.env.EXPRESS_SERVER_PORT);

const main = async () => {

    // Creates strapi client instance
    const strapiClient = new StrapiClient(
        STRAPI_HOST, STRAPI_PORT,
        EXPRESS_HOST, EXPRESS_PORT
    );

    // Creates websocket client instance
    const wsClient = new WSClient(
        WS_HOST, WS_PORT
    );

    // Creates engine instance
    const engine = new Engine(wsClient, strapiClient);

    // Start the engine systems
    engine.start();

    // Start the engine game loop
    await engine.loop();

    // Properly close the engine
    engine.close();
}

main();