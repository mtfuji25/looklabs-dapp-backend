import { Engine } from "./Core/Engine";
import { WSClient } from "./Clients/WebSocket";
import { StrapiClient } from "./Clients/Strapi";
import { Logger } from "./Utils/Logger";
import * as Sentry from "@sentry/node";
import { LogStorageClient } from "./Clients/LogStorage";

import * as dotenv from "dotenv";
dotenv.config({ path: "../.env" });

Sentry.init({
  dsn: "https://0310fb88d0254835be8a3d60b9a17bd6@o1091574.ingest.sentry.io/6108697",
  // We recommend adjusting this value in production, or using tracesSampler
  // for finer control
  tracesSampleRate: 1.0,
});

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
    const strapiClient = new StrapiClient(STRAPI_SERVER_HOST, STRAPI_BEARER_TOKEN);

    // Start websocket client
    const wsClient = new WSClient(WS_HOST, WS_PORT);

    // Log storage client
    const logStorageClient = new LogStorageClient(PROJECT_ID);

    const engine = new Engine(wsClient, strapiClient, logStorageClient);

    // Start the engine systems
    await engine.start();

    // Start the engine game loop
    await engine.loop();

    // Properly close the engine
    await engine.close();
};

main();
