import { Level } from "./Level";
import { DefaultLevel } from "../Levels/Default";

// Interfaces imports
import { EngineContext } from "./Interfaces";

// Utils imports
import { sleep } from "../Utils/Sleep";

// Web clients imports
import { WSClient } from "../Clients/WebSocket";
import { StrapiClient } from "../Clients/Strapi";

class Engine {

    // WebSocket client instance
    private wsClient: WSClient;

    // Strapi client Instance
    private strapiClient: StrapiClient;

    // Current level instnace
    private level: Level;

    // Engine context
    private context: EngineContext;

    constructor(wsClient: WSClient, strapiClient: StrapiClient) {
        this.wsClient = wsClient;
        this.strapiClient = strapiClient;

        this.context = {
            engine: this,
            ws: this.wsClient,
            strapi: this.strapiClient,
            stats: {
                dt: 0.0,
                fps: 0.0,
                start: Date.now(),
            },
            close: false
        };

        // Make new instance of default level as current
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
        
        while (!this.context.close) {
            // Calculates the delta time of the loop
            const current = Date.now();
            this.context.stats.dt = (current - this.context.stats.start) / 1000.0;
            this.context.stats.start = current;
            this.context.stats.fps = 1.0 / this.context.stats.dt;

            // Run update fn of current level
            this.level.onUpdate(this.context.stats.dt);

            // Run systems pendings
            this.level.runPendings(this.context.stats.dt)

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