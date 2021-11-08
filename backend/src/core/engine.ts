import { Level } from "./level";
import { DefaultLevel } from "../levels/default";
import { WSClient } from "../clients/websocket";
import { EngineContext } from "./interfaces";
import { sleep } from "../utils/sleep";
import { StrapiClient } from "../clients/strapi";

class Engine {

    // WebSocket server instance
    private wsClient: WSClient;

    // Strapi Client Instance
    private strapiClient: StrapiClient;

    // Engine context
    private context: EngineContext;

    private level: Level;

    constructor(wsClient: WSClient, strapiClient: StrapiClient) {
        this.wsClient = wsClient;
        this.strapiClient = strapiClient;

        this.context = {
            engine: this,
            wsClient: this.wsClient,
            strapiClient: this.strapiClient,
            stats: {
                fps: 0.0,
                frameStart: Date.now(),
                deltaTime: 0.0
            },
            closeRequest: false
        };

        this.level = new DefaultLevel(this.context); 
    }

    start(): void {
        console.log("Starting backend engine.");

        // Start engine Web Socket client
        this.wsClient.start();

        // Start strapi client
        this.strapiClient.start();

        // Finally load the default level
        console.log("Loading level: ", this.level.getName());
        this.level.onStart();
    }

    async loop() {
        console.log("Entering main engine loop");
        
        while (!this.context.closeRequest) {
            // Calculates the delta time of the loop
            const current = Date.now();
            this.context.stats.deltaTime = (current - this.context.stats.frameStart) / 1000.0;
            this.context.stats.frameStart = current;
            this.context.stats.fps = 1.0 / this.context.stats.deltaTime;

            // Run update fn of current level
            this.level.onUpdate(this.context.stats.deltaTime);

            // Run systems pendings
            this.level.runPendings(this.context.stats.deltaTime)

            await sleep(15);
        }
    }

    close(): void {
        console.log("Closing backend engine.");

        // Close current active level
        this.closeLevel(this.level);

        // Close strapi client
        this.strapiClient.close();

        // Close engine Web Socket client
        this.wsClient.close();
    }

    loadLevel(level: Level): void {
 
        // First close the current running level
        this.closeLevel(this.level);
            
        console.log("Loading level: ", level.getName());

        // Set level as current in context
        this.level = level;

        // Start level and put it to run
        level.onStart();
    }

    closeLevel(level: Level): void {

        console.log("Closing level: ", level.getName());

        // Close all level's systems
        level.closeSystems();

        // Fire the onClose function on current level
        level.onClose();
    }
};

export { Engine };