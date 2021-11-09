import { Level } from "./level";
import { DefaultLevel } from "../levels/default";
import { WSClient } from "../clients/websocket";
import { EngineContext } from "./interfaces";
import { sleep } from "../utils/sleep";
import { Application } from "pixi.js";

// Require the resources.json
import resourceFile from "../assets/resource.json";
import { initInputs, inputs } from "./inputs/inputs";
// Cast to something that typescript can understand
const resources: Record<string, any> = resourceFile;

class Engine {

    // WebSocket server instance
    private wsClient: WSClient;
    
    // Pixi application instance
    private app: Application;

    // Canvas root div
    private root: HTMLElement;

    // Engine context
    private context: EngineContext;

    // Running Level
    private level: Level;

    constructor(wsClient: WSClient, app: Application, root: HTMLElement) {
        this.wsClient = wsClient;
        this.app = app;
        this.root = root;

        initInputs(this.app);

        this.context = {
            engine: this,
            wsClient: this.wsClient,
            app: this.app,
            root: this.root,
            inputs: inputs,
            resources: resources,
            stats: {
                fps: 0.0,
                frameStart: Date.now(),
                deltaTime: 0.0
            },
            closeRequest: false
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