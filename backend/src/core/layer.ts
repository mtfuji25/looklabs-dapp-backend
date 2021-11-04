
abstract class Layer {
    
    protected name: string;

    constructor(name: string = "Default") {
        this.name = name;
    }

    abstract onAttach(): void;
    abstract onDetach(): void;
    abstract onUpdate(deltaTime: number): void;

    getName() { return this.name; }
};

export { Layer };
