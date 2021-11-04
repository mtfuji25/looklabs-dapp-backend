import { ECS } from "./ecs/core/ecs";
import { LayerStack } from "./layer-stack";

abstract class Level {
    
    protected name: string;
    protected ecs: ECS;
    protected layerStack: LayerStack;

    constructor(name: string = "Default") {
        this.name = name;
        this.ecs = new ECS();
        this.layerStack = new LayerStack();
    }

    abstract onStart(): void;
    abstract onClose(): void;

    getName() { return this.name; }
};

export { Level };
