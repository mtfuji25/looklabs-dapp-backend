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
import { StrapiClient } from "../Clients/Strapi2";

// Pixi imports
import { Application, SCALE_MODES, settings } from "pixi.js";
import { Logger } from "../Utils/Logger";
// Require the resources.json
import resourceFile from "../Assets/Resources.json";
import { AssetLoader } from "./AssetLoader";
import { ParticipantDetailsModel } from "./PlayerModel";

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
    private assetLoader:AssetLoader;
    private participantDetails:ParticipantDetailsModel;


    constructor(wsClient: WSClient, strapiClient: StrapiClient, app: Application, root: HTMLElement) {
        this.wsClient = wsClient;
        this.strapiClient = strapiClient;
        this.app = app;
        this.root = root;
        this.assetLoader = new AssetLoader(this.app);
        this.participantDetails = new ParticipantDetailsModel(this.strapiClient);
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
            assetLoader: this.assetLoader,
            participantDetails: this.participantDetails,
            close: false
        };

        this.level = new DefaultLevel(this.context); 
    }

    async start(): Promise<void> {
        Logger.info("Starting frontend engine.");

        // Configure pixi application
        // Append the base application to the root div of index.html
        this.root.appendChild(this.app.view);

        // Make sure that the application is able to listen to events
        this.app.stage.interactive = true;

        this.assetLoader.loadFromJSON(resources);

        // Start engine Web Socket client
        this.wsClient.start();

        // Finally load the default level
        Logger.info("Loading level: ", this.level.getName());
        await this.level.onStart();
    }

    async loop(): Promise<void> {
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

            await sleep(1);
        }
    }

    async close(): Promise<void> {
        Logger.info("Closing frontend engine.");

        // Close current active level
        this.closeLevel(this.level);

        // Close engine Web Socket client
        this.wsClient.close();
    }

    async loadLevel(level: Level): Promise<void> {
 
        // First close the current running level
        await this.closeLevel(this.level);
            
        Logger.info("Loading level: ", level.getName());

        // Set level as current in context
        this.level = level;

        // Start level and put it to run
        await level.onStart();
    }

    async closeLevel(level: Level): Promise<void> {

        Logger.info("Closing level: ", level.getName());

        // Close all level's systems
        await level.closeSystems();

        // Fire the onClose function on current level
        await level.onClose();
    }
};

export { Engine };