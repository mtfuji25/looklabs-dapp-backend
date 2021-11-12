import { Layer } from "../core/layer";
import { ECS } from "../core/ecs/core/ecs";

import { Text } from "pixi.js";

class ViewLayer extends Layer {

    constructor(ecs: ECS) {
        super("TesteLayer", ecs);

    }

    onAttach() {
        
    }

    onUpdate(deltaTime: number) {
        
    }

    onDetach() {
        this.self.destroy();
    }
};

export { ViewLayer };
