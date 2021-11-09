import { Engine } from "./engine";
import { WSClient } from "../clients/websocket";
import { SpriteComponent } from "./ecs/components/sprite";
import { TransformComponent } from "./ecs/components/transform";
import { AnimSpriteComponent } from "./ecs/components/animsprite";
import { Application } from "pixi.js";
import { Inputs } from "./inputs/inputs";

interface EcsData {
    sprites: SpriteComponent[];
    animsprites: AnimSpriteComponent[];
    transforms: TransformComponent[];
}

interface EngineStats {
    fps: number;
    frameStart: number;
    deltaTime: number;
}

interface EngineContext {
    engine: Engine;
    wsClient: WSClient;
    app: Application;
    root: HTMLElement;
    inputs: Inputs;
    resources: Record<string, any>;
    stats: EngineStats;
    closeRequest: boolean;
}

export { EngineContext, EngineStats, EcsData };