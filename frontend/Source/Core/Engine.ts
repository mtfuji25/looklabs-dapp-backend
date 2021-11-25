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
import { Application } from "pixi.js";

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

    start(asyncStart: () => (void)): void {
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

        this.app.loader.onComplete.add(() => {
            this.levelStart(asyncStart);
        });

        // Start engine Web Socket client
        this.wsClient.start();

        // Effectlly load all the resources
        this.app.loader.load();
    }

    private levelStart(asyncStart: () => (void)): void {
        // Finally load the default level
        console.log("Loading level: ", this.level.getName());
        this.level.onStart();

        asyncStart();
    }

    private count = 1000;

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

            await sleep(1);
        }
    }

    close(): void {
        console.log("Closing backend engine.");

        // Close current active level
        this.closeLevel(this.level);

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