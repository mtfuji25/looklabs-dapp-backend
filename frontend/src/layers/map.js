import { ECS } from "../ecs/core/ecs";

import resources from "../resource.json";
import level from "../level.json";

import * as PIXI from "pixi.js";
import { BTNS, inputs } from "../inputs/inputs";

class Map {
    constructor(app) {
        this.app = app;
        this.entities = [];
        this.container = new PIXI.Container();
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
                this.container.addChild(sprite.sprite);

                x += 32;
            }
            x = 0;
            y += 32;
        }
        this.container.filters = [ new PIXI.filters.BlurFilter(1, 8) ];
        this.app.stage.addChild(this.container);
    }

    onUpdate(deltaTime) {
    }
}

export { Map };