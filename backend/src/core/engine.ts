import { Level } from "./level";
import { DefaultLevel } from "../levels/default";
import { WSClient } from "../clients/websocket";
import { ECS, Entity, Grid, Transform } from "./ecs/core/ecs";

class Engine {

    private wsClient: WSClient;

    constructor(wsClient: WSClient) {
        this.wsClient = wsClient;
    }

    start(): void {
        console.log("starting engine");

        // Start engine Web Socket client
        this.wsClient.start();

        // Finally load the default level
        this.loadLevel(new DefaultLevel());
    }

    loop(): void {
        console.log("looping engine");
    }

    close(): void {
        // Close engine Web Socket client
        this.wsClient.close();
        
        console.log("closing engine");
    }

    loadLevel(level: Level): void {
        console.log("loading level in engine");
    }

};

export { Engine };