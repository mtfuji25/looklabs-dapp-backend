import { Level } from "./Level";
import { DefaultLevel } from "../Levels/Default";

// Interfaces imports
import { EngineContext } from "./Interfaces";

// Utils imports
import { sleep } from "../Utils/Sleep";

// Input system import
import { initInputs, inputs } from "./Inputs/Inputs";

// Web clients imports
import { WSClient } from "../Clients/WebSocket";
import { StrapiClient } from "../Clients/Strapi";

// Pixi imports
import { Application, SCALE_MODES, settings } from "pixi.js";

// Require the resources.json
import resourceFile from "../Assets/Resources.json";

// Cast to something that typescript can understand
const resources: Record<string, any> = resourceFile;

class Engine {

    // WebSocket server instance
    private wsClient: WSClient;
    
    // Strapi client instance
    private strapiClient: StrapiClient;

    // Pixi application instance
    private app: Application;

    // Canvas root div
    private root: HTMLElement;

    // Engine context
    private context: EngineContext;

    // Running Level
    private level: Level;

    constructor(wsClient: WSClient, strapiClient: StrapiClient, app: Application, root: HTMLElement) {
        this.wsClient = wsClient;
        this.strapiClient = strapiClient;
        this.app = app;
        this.root = root;

        initInputs(this.app);

        this.context = {
            engine: this,
            ws: this.wsClient,
            strapi: this.strapiClient,
            app: this.app,
            root: this.root,
            inputs: inputs,
            res: resources,
            stats: {
                fps: 0.0,
                start: Date.now(),
                dt: 0.0
            },
            close: false
        };

        this.level = new DefaultLevel(this.context); 
    }

    async start(): Promise<void> {
        console.log("Starting backend engine.");

        // Configure pixi application
        // Append the base application to the root div of index.html
        this.root.appendChild(this.app.view);

        // Make sure that the application is able to listen to events
        this.app.stage.interactive = true;

        // Add all resources to loader queue
        resources["packs"].forEach((pack: string) => {
            this.app.loader.add(resources[pack]);
        });

        // Start engine Web Socket client
        this.wsClient.start();

        // Effectlly load all the resources
        // set settings for texturs (settings ideal for pixel based game)
        settings.SCALE_MODE = SCALE_MODES.NEAREST;
        
        this.app.loader.load();

        // Finally load the default level
        console.log("Loading level: ", this.level.getName());
        await this.level.onStart();
    }

    async loop(): Promise<void> {
        console.log("Entering main engine loop");
        
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

            await sleep(1);
        }
    }

    async close(): Promise<void> {
        console.log("Closing backend engine.");

        // Close current active level
        this.closeLevel(this.level);

        // Close engine Web Socket client
        this.wsClient.close();
    }

    async loadLevel(level: Level): Promise<void> {
 
        // First close the current running level
        await this.closeLevel(this.level);
            
        console.log("Loading level: ", level.getName());

        // Set level as current in context
        this.level = level;

        // Start level and put it to run
        await level.onStart();
    }

    async closeLevel(level: Level): Promise<void> {

        console.log("Closing level: ", level.getName());

        // Close all level's systems
        await level.closeSystems();

        // Fire the onClose function on current level
        await level.onClose();
    }
};

export { Engine };