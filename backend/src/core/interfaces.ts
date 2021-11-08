import { Engine } from "./engine";
import { WSClient } from "../clients/websocket";
import { GridComponent } from "./ecs/components/grid";
import { RectangleComponent } from "./ecs/components/rectangle";
import { RigidbodyComponent } from "./ecs/components/rigidbody";
import { TransformComponent } from "./ecs/components/transform";
import { StrapiClient } from "../clients/strapi";
import { StatusComponent } from "./ecs/components/status";

interface EcsData {
    grids: GridComponent[];
    rectangles: RectangleComponent[];
    rigidbodys: RigidbodyComponent[];
    transforms: TransformComponent[];
    status: StatusComponent[];
}

interface EngineStats {
    fps: number;
    frameStart: number;
    deltaTime: number;
}

interface EngineContext {
    engine: Engine;
    wsClient: WSClient;
    strapiClient: StrapiClient;
    stats: EngineStats;
    closeRequest: boolean;
}

export { EngineContext, EngineStats, EcsData };