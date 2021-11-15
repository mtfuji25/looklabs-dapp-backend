// Engine import
import { Engine } from "./Engine";

// Web clients imports
import { WSClient } from "../Clients/WebSocket";
import { StrapiClient } from "../Clients/Strapi";

interface EngineStats {
    // Level's deltatime
    dt: number;

    // Current frames per second rate
    fps: number;

    // Current frame start time
    start: number;
}

interface EngineContext {
    // Current engine instance
    engine: Engine;

    // Web Clients instances
    ws: WSClient;
    strapi: StrapiClient;

    // Engine control
    stats: EngineStats;
    close: boolean;
}

export { EngineContext, EngineStats };