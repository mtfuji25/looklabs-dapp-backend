import { ECS } from "../ecs/core/ecs";

import * as PIXI from "pixi.js";

import level_soil from "../level_soil.json";
import level_wall from "../level_wall.json";


class Map {
    constructor(app) {
        this.app = app;
        this.entities = [];
        this.soilContainer = new PIXI.Container();
        this.wallContainer = new PIXI.Container();
    }

    loadSoil() {
        let rows = level_soil["height"];
        let cols = level_soil["width"];

        let x = 0.0;
        let y = 0.0;

        let entity;
        let sprite;
        for (let i = 0; i < rows; ++i) {
            for (let j = 0; j < cols; ++j) {
                let currentSheet = level_soil["mappings"][level_soil["data"][i][j]];
                if (currentSheet != "empty") {
                    entity = ECS.createEntity(x, y, ECS.SPRITE);
                    this.entities.push(entity);
                    sprite = ECS.getComponent(entity, ECS.SPRITE);
                    sprite.setImg(this.app.loader.resources[currentSheet]);
                    this.soilContainer.addChild(sprite.sprite);
                }
                x += 32;
            }
            x = 0;
            y += 32;
        }
    }

    loadWall() {
        let rows = level_wall["height"];
        let cols = level_wall["width"];

        let x = 0.0;
        let y = 0.0;

        let entity;
        let sprite;
        for (let i = 0; i < rows; ++i) {
            for (let j = 0; j < cols; ++j) {
                let currentSheet = level_wall["mappings"][level_wall["data"][i][j]];
                if (currentSheet != "empty") {
                    entity = ECS.createEntity(x, y, ECS.SPRITE);
                    this.entities.push(entity);
                    sprite = ECS.getComponent(entity, ECS.SPRITE);
                    sprite.setImg(this.app.loader.resources[currentSheet]);
                    this.wallContainer.addChild(sprite.sprite);
                }
                x += 32;
            }
            x = 0;
            y += 32;
        }
    }

    onAttach() {
        this.loadSoil();
        this.loadWall();

        // Apply a ligth blur on the soil
        this.soilContainer.filters = [ new PIXI.filters.BlurFilter(1, 8) ];

        // Add both layers to render stage
        this.app.stage.addChild(this.soilContainer);
        this.app.stage.addChild(this.wallContainer);
    }

    onUpdate(deltaTime) {
        let view = ECS.getGlobal("view");

        // Translate and scale soil
        this.soilContainer.x = view.value.xOffset;
        this.soilContainer.y = view.value.yOffset;
        this.soilContainer.scale.x = 1 - view.value.zoom;
        this.soilContainer.scale.y = 1 - view.value.zoom;

        // Translate and scale walls
        this.wallContainer.x = view.value.xOffset;
        this.wallContainer.y = view.value.yOffset;
        this.wallContainer.scale.x = 1 - view.value.zoom;
        this.wallContainer.scale.y = 1 - view.value.zoom;
    }
}

export { Map };