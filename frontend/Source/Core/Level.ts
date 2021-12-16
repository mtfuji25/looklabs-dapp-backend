import { ECS } from "./Ecs/Core/Ecs";

// Layers imports
import { Layer } from "./Layer";
import { LayerStack } from "./LayerStack";

// Engine imports
import { EngineContext } from "./Interfaces";

//Pixi Sound
import { sound } from "@pixi/sound";

abstract class Level {
    
    // Name of the current runnign level
    protected name: string;

    // Current level's ECS instance
    protected ecs: ECS;

    // Current level's Layer Stack instance
    protected layerStack: LayerStack;

    // Main Engine context
    protected context: EngineContext;

    // Specific level's properties
    protected props: Record<string, any>;

    constructor(context: EngineContext, name: string = "Default", props: Record<string, any> = {}) {
        this.name = name;
        this.props = props;
        this.context = context;

        // Creates current level systems instances
        this.ecs = new ECS();
        this.layerStack = new LayerStack();
    }

    runPendings(deltaTime: number) {
        // Update ECS systems
        this.ecs.onUpdate(deltaTime);

        // Update all level's layers
        this.layerStack.layers.map((layer: Layer) => {
            layer.onUpdate(deltaTime);
        })
    }

    closeSystems() {
        this.layerStack.destroy();
        this.ecs.destroy();
    }

    abstract onStart(): void;
    abstract onUpdate(deltaTime: number): void;
    abstract onClose(): void;
    

    getName() { return this.name; }

    playBackgroundMusic(soundRes:string):void {
        sound.stopAll();
        if (this.context.app.loader.resources[soundRes]) {
            sound.play(soundRes, {loop: true});
        }
    }

    static AWAIT_SOUND:string = "lobby_sound";
    static LOBBY_SOUND:string = "battle_sound";
    static RESULTS_SOUND:string = "results_sound";
    static SHOWDOWN_SOUND:string = "showdown_sound";
};

export { Level };
