import { ECS, Entity } from "./Ecs/Core/Ecs";

abstract class Layer {
    
    protected name: string;

    // current ecs instance
    protected ecs: ECS;
    
    // current entity instance
    protected self: Entity;

    constructor(name: string = "Default", ecs: ECS) {
        this.name = name;
        this.ecs = ecs;
        
        // Create default layer's entity
        this.self = this.ecs.createEntity();
    }

    abstract onAttach(): void;
    abstract onDetach(): void;
    abstract onUpdate(deltaTime: number): void;

    getSelf() { return this.self; }
    getName() { return this.name; }
};

export { Layer };
