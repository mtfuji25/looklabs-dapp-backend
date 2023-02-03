import { Engine } from "./Core/Engine";
import { WSClient } from "./Clients/WebSocket";
import { MockedApi } from "./Clients/MockedApi";
import { StrapiClient } from "./Clients/Strapi";
import { Logger } from "./Utils/Logger";
import { LogStorageClient } from "./Clients/LogStorage";

import * as dotenv from "dotenv";
dotenv.config({ path: "../.env" });

const STRAPI_SERVER_HOST = String(process.env.STRAPI_SERVER_HOST);
const STRAPI_BEARER_TOKEN = String(process.env.STRAPI_BEARER_TOKEN);

const WS_PORT = Number(process.env.WS_SERVER_PORT);
const WS_HOST = String(process.env.WS_SERVER_HOST);

const PROJECT_ID = String(process.env.PROJECT_ID);

const LOGGER_LEVEL = Number("0b" + String(process.env.LOGGER_LEVEL));

const main = async () => {

    // Starts logger class
    Logger.start(LOGGER_LEVEL);

    // Start strapi client
    // const strapiClient = new StrapiClient(STRAPI_SERVER_HOST, STRAPI_BEARER_TOKEN);
    const strapiClient = new MockedApi(STRAPI_SERVER_HOST, STRAPI_BEARER_TOKEN);

    // Start websocket client
    const wsClient = new WSClient(WS_HOST, WS_PORT);

    // Log storage client
    const logStorageClient = new LogStorageClient("the-pit-328710");

    const engine = new Engine(wsClient, strapiClient, logStorageClient);

    // Start the engine systems
    await engine.start();

    // Start the engine game loop
    await engine.loop();

    // Properly close the engine
    await engine.close();
};

main();
