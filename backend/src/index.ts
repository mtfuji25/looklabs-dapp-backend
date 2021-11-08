import { Engine } from "./core/engine"
import { WSClient } from "./clients/websocket";
import { StrapiClient } from "./clients/strapi";

import * as dotenv from "dotenv";
dotenv.config();

const STRAPI_PORT = Number(process.env.STRAPI_SERVER_PORT);
const EXPRESS_PORT = Number(process.env.EXPRESS_SERVER_PORT);
const WS_PORT = Number(process.env.WS_SERVER_PORT);

const main = async () => {

    // Start strapi client
    const strapiClient = new StrapiClient(STRAPI_PORT, EXPRESS_PORT);

    // Start websocket client
    const wsClient = new WSClient(WS_PORT);

    const engine = new Engine(wsClient, strapiClient);

    // Start the engine systems
    engine.start();

    // Start the engine game loop
    await engine.loop();

    // Properly close the engine
    engine.close();
}

main();