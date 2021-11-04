import { Engine } from "./core/engine"
import { WSClient } from "./clients/websocket";

import * as dotenv from "dotenv";
dotenv.config();

type BitMaskedId = Record<number, number>;

const main = async () => {

    // Start websocket client
    const wsClient = new WSClient(Number(process.env.WS_SERVER_PORT));

    const engine = new Engine(wsClient);

    // Start the engine systems
    engine.start();

    // Start the engine game loop
    engine.loop();

    // Properly close the engine
    engine.close();
}

main()