// Engine import
import { Engine } from "./Engine";

// Web clients imports
import { WSClient } from "../Clients/WebSocket";
import { StrapiClient } from "../Clients/Strapi";

// Pixi import
import { Application } from "pixi.js";

// Inputs
import { Inputs } from "./Inputs/Inputs";
import { AssetLoader } from "./AssetLoader";
import { ParticipantDetailsModel } from "./PlayerModel";

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

    // Pixi and canvas
    app: Application;
    root: HTMLElement;

    // Inputs system
    inputs: Inputs;

    // Resources
    res: Record<string, any>;
    assetLoader:AssetLoader;
    participantDetails:ParticipantDetailsModel;
    // Engine control
    stats: EngineStats;
    close: boolean;
}

export { EngineContext, EngineStats };