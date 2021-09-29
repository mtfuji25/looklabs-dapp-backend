
import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";

const FLOOR_SPIRTE_SIZE = 64;

class Map {
    constructor(app) {
        this.app = app;
        this.width = 0;
        this.height = 0;
        this.floor = [];
    }

    

    onUpdate(deltaTime) {
        
    }
}

export { Map };