import { ECS, Entity } from "./ecs/core/ecs";

abstract class Layer {
    
    protected name: string;

    // current ecs instance
    protected ecs: ECS;
    
    // current entity instance
    protected self: Entity;

    constructor(name: string = "Default", ecs: ECS) {
        this.name = name;
        this.ecs = ecs;
        
        this.self = this.ecs.createEntity();
    }

    abstract onAttach(): void;
    abstract onDetach(): void;
    abstract onUpdate(deltaTime: number): void;

    getSelf() { return this.self; }
    getName() { return this.name; }
};

export { Layer };
