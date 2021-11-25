import { Engine } from "./core/engine";
<<<<<<< HEAD:backend/Source/Index.ts
import { WSClient } from "./Clients/WebSocket";
import { StrapiClient } from "./Clients/Strapi";
=======
import { WSClient } from "./clients/websocket";
import { StrapiClient } from "./clients/strapi";
>>>>>>> development:backend/src/index.ts

import * as dotenv from "dotenv";
dotenv.config();

const STRAPI_SERVER_URL = String(process.env.STRAPI_SERVER_URL);
const EXPRESS_PORT = Number(process.env.EXPRESS_SERVER_PORT);
const WS_PORT = Number(process.env.WS_SERVER_PORT);
const WS_HOST = String(process.env.WS_SERVER_HOST);

const main = async () => {
<<<<<<< HEAD:backend/Source/Index.ts
    // Start strapi client
    const strapiClient = new StrapiClient(STRAPI_SERVER_URL);

    // Start websocket client
    const wsClient = new WSClient(WS_HOST, WS_PORT);
=======
  // Start strapi client
  const strapiClient = new StrapiClient(STRAPI_SERVER_URL, EXPRESS_PORT);

  // Start websocket client
  const wsClient = new WSClient(WS_PORT);

  const engine = new Engine(wsClient, strapiClient);
>>>>>>> development:backend/src/index.ts

  // Start the engine systems
  engine.start();

  // Start the engine game loop
  await engine.loop();

  // Properly close the engine
  engine.close();
};

<<<<<<< HEAD:backend/Source/Index.ts
    // Properly close the engine
    engine.close();
};

=======
>>>>>>> development:backend/src/index.ts
main();
