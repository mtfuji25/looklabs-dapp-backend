import { ECS } from "../ecs/core/ecs";

import resources from "../resource.json";
import level from "../level.json";

class Map {
    constructor(app) {
        this.app = app;
        this.entities = [];
    }

    onAttach() {
        let rows = level["layer0"]["height"];
        let cols = level["layer0"]["width"];

        let x = 0.0;
        let y = 0.0;

        let entity;
        let sprite;
        for (let i = 0; i < rows; ++i) {
            for (let j = 0; j < cols; ++j) {
                let currentSheet = level["layer0"]["mappings"][level["layer0"]["data"][i][j]];

                entity = ECS.createEntity(x, y, ECS.SPRITE);
                this.entities.push(entity);
                sprite = ECS.getComponent(entity, ECS.SPRITE);
                sprite.setImg(this.app.loader.resources[currentSheet]);
                sprite.addStage(this.app);

                x += 32;
            }
            x = 0;
            y += 32;
        }
    }

    onUpdate(deltaTime) {
        
    }
}

export { Map };