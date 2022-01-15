import { Level } from "./Level";
import { DefaultLevel } from "../Levels/Default";

// Interfaces imports
import { EngineContext } from "./Interfaces";

// Utils imports
import { sleep } from "../Utils/Sleep";

// Web clients imports
import { WSClient } from "../Clients/WebSocket";
import { StrapiClient } from "../Clients/Strapi";
import { LogStorageClient } from "../Clients/LogStorage";
import { Logger } from "../Utils/Logger";

class Engine {

    // WebSocket client instance
    private wsClient: WSClient;

    // Strapi client Instance
    private strapiClient: StrapiClient;

    // Log Storage Client Instance
    private logStorageClient: LogStorageClient;

    // Current level instnace
    private level: Level;

    // Engine context
    private context: EngineContext;

    constructor(wsClient: WSClient, strapiClient: StrapiClient, logStorageClient: LogStorageClient) {
        this.wsClient = wsClient;
        this.strapiClient = strapiClient;
        this.logStorageClient = logStorageClient;

        this.context = {
            engine: this,
            ws: this.wsClient,
            strapi: this.strapiClient,
            logStorage: this.logStorageClient,
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

    // Default engine's start method
    async start() {
        Logger.info("Starting backend engine.");

        // Start engine Web Socket client
        this.wsClient.start();

        // Start strapi client
        this.strapiClient.start();

        // Start Log storage client
        await this.logStorageClient.start();

        // Finally load the default level
        Logger.info("Loading level: ", this.level.getName());

        // Maybe IDE tells that await has no effect, but is because
        // it is an abstract method, but it's necessary to await
        await this.level.onStart();
    }

    // Default engine's loop method
    async loop() {
        Logger.info("Entering main engine loop");
        
        while (!this.context.close) {
            // Calculates the delta time of the loop
            const current = Date.now();
            this.context.stats.dt = (current - this.context.stats.start) / 1000.0;
            this.context.stats.start = current;
            this.context.stats.fps = 1.0 / this.context.stats.dt;

            // Run update fn of current level
            await this.level.onUpdate(this.context.stats.dt);

            // Run systems pendings
            await this.level.runPendings(this.context.stats.dt)

            await sleep(15);
        }
    }

    // Default engine's close method
    async close() {
        Logger.info("Closing backend engine.");

        // Close current active level
        await this.closeLevel(this.level);

        // Close strapi client
        this.strapiClient.close();

        // Close engine Web Socket client
        this.wsClient.close();

        // Disconnect log storage client
        await this.logStorageClient.close();
    }

    async loadLevel(level: Level) {
 
        // First close the current running level
        await this.closeLevel(this.level);
            
        Logger.info("Loading level: ", level.getName());

        // Set level as current in context
        this.level = level;

        // Start level and put it to run
        await level.onStart();
    }

    async closeLevel(level: Level) {

        Logger.info("Closing level: ", level.getName());

        // Close all level's systems
        level.closeSystems();

        // Fire the onClose function on current level
        await level.onClose();
    }
};

export { Engine };