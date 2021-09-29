
import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";

import resources from "../resource.json";

import fase from "../fase.json";

const FLOOR_SPIRTE_SIZE = 100.0;

class Map {
    constructor(app) {
        this.app = app;
        this.width = 0;
        this.height = 0;
        this.rows = 0;
        this.cols = 0;
        this.map = [];
    }

    initConst() {
        this.width = this.app.view.width;
        this.height = this.app.view.height;

        this.rows = Math.ceil(this.height / FLOOR_SPIRTE_SIZE);
        this.colums = Math.ceil(this.width / FLOOR_SPIRTE_SIZE);

        let test = [ "bw", "wb", "wr", "wp", "wg" ];
        let counter = 0;
        let x = 0.0;
        let y = 0.0;

        let entity;
        let sprite;
        let rectangle;
        for (let i = 0; i < this.rows; ++i) {
            entity = 0;
            sprite = 0;
            rectangle = 0;
            for (let j = 0; j < this.colums; ++j) {
                let currentSheet = fase["layout"][i][j];
                if (currentSheet != 0) {
                    switch (currentSheet) {
                        case 1:
                            entity = ECS.createEntity(x, y, ECS.SPRITE | ECS.RECTANGLE);
                            this.map.push(entity);
                            sprite = ECS.getComponent(entity, ECS.SPRITE);
                            rectangle = ECS.getComponent(entity, ECS.RECTANGLE);
                            sprite.setImg(this.app.loader.resources["terra-main"]);
                            sprite.addStage(this.app);
                            rectangle.width = 100;
                            rectangle.height = 100;
                            break;
                        case 2:
                            entity = ECS.createEntity(x, y, ECS.SPRITE | ECS.RECTANGLE);
                            this.map.push(entity);
                            sprite = ECS.getComponent(entity, ECS.SPRITE);
                            rectangle = ECS.getComponent(entity, ECS.RECTANGLE);
                            sprite.setImg(this.app.loader.resources["grama"]);
                            sprite.addStage(this.app);
                            rectangle.width = 100;
                            rectangle.height = 100;
                            break;
                        case 3:
                            entity = ECS.createEntity(x, y, ECS.SPRITE | ECS.RECTANGLE);
                            this.map.push(entity);
                            sprite = ECS.getComponent(entity, ECS.SPRITE);
                            rectangle = ECS.getComponent(entity, ECS.RECTANGLE);
                            sprite.setImg(this.app.loader.resources["flte"]);
                            sprite.addStage(this.app);
                            rectangle.width = 100;
                            rectangle.height = 100;
                            break;
                        case 4:
                            entity = ECS.createEntity(x, y, ECS.SPRITE | ECS.RECTANGLE);
                            this.map.push(entity);
                            sprite = ECS.getComponent(entity, ECS.SPRITE);
                            rectangle = ECS.getComponent(entity, ECS.RECTANGLE);
                            sprite.setImg(this.app.loader.resources["fld"]);
                            sprite.addStage(this.app);
                            rectangle.width = 100;
                            rectangle.height = 100;
                            break;
                        case 5:
                            entity = ECS.createEntity(x, y, ECS.ANIMSPRITE | ECS.RECTANGLE);
                            this.map.push(entity);
                            sprite = ECS.getComponent(entity, ECS.ANIMSPRITE);
                            rectangle = ECS.getComponent(entity, ECS.RECTANGLE);
                            sprite.loadFromConfig(this.app, resources["sprite-sheet-coin"]);
                            sprite.animate(resources["sprite-sheet-coin"]["animations"][0]);
                            sprite.addStage(this.app);
                            rectangle.width = 100;
                            rectangle.height = 100;
                            sprite.setScale(
                                0.5, 0.5
                            )
                            break;
                        case 8:
                            entity = ECS.createEntity(x, y, ECS.SPRITE | ECS.RECTANGLE);
                            this.map.push(entity);
                            sprite = ECS.getComponent(entity, ECS.SPRITE);
                            rectangle = ECS.getComponent(entity, ECS.RECTANGLE);
                            sprite.setImg(this.app.loader.resources["agua"]);
                            sprite.addStage(this.app);
                            rectangle.width = 100;
                            rectangle.height = 100;
                            break;
                        case 9:
                            entity = ECS.createEntity(x, y, ECS.SPRITE | ECS.RECTANGLE);
                            this.map.push(entity);
                            sprite = ECS.getComponent(entity, ECS.SPRITE);
                            rectangle = ECS.getComponent(entity, ECS.RECTANGLE);
                            sprite.setImg(this.app.loader.resources["water-base"]);
                            sprite.addStage(this.app);
                            rectangle.width = 100;
                            rectangle.height = 100;
                            break;
                        case 7:
                            entity = ECS.createEntity(x, y, ECS.SPRITE | ECS.RECTANGLE);
                            this.map.push(entity);
                            sprite = ECS.getComponent(entity, ECS.SPRITE);
                            rectangle = ECS.getComponent(entity, ECS.RECTANGLE);
                            sprite.setImg(this.app.loader.resources["caixa"]);
                            sprite.addStage(this.app);
                            rectangle.width = 100;
                            rectangle.height = 100;
                            break;
                        case 6:
                            entity = ECS.createEntity(x, y, ECS.ANIMSPRITE | ECS.RECTANGLE);
                            this.map.push(entity);
                            sprite = ECS.getComponent(entity, ECS.ANIMSPRITE);
                            rectangle = ECS.getComponent(entity, ECS.RECTANGLE);
                            sprite.loadFromConfig(this.app, resources["sprite-sheet-enemy"]);
                            sprite.animate(resources["sprite-sheet-enemy"]["animations"][0]);
                            sprite.addStage(this.app);
                            rectangle.width = 100;
                            rectangle.height = 100;
                            break;
                    }
                }
                x += 100;
            }
            x = 0;
            y += 100;
        }
        
    }

    onAttach() {
        this.test = ECS.createEntity(300, 400, ECS.ANIMSPRITE | ECS.RECTANGLE);
        let sprite = ECS.getComponent(this.test, ECS.ANIMSPRITE);
        sprite.loadFromConfig(this.app, resources["sprite-sheet-enemy"]);
        sprite.transform.pos.x = 500;
        sprite.transform.pos.y = 500;
        sprite.addStage(this.app);
        let rec = ECS.getComponent(this.test, ECS.RECTANGLE);
        rec.width = 100;
        rec.height = 100;
        rec.needCheck = true;

        this.initConst();
    }

    onUpdate(deltaTime) {
        let transf = ECS.getComponent(this.test, ECS.TRANSFORM);
        let sprite = ECS.getComponent(this.test, ECS.ANIMSPRITE);
        transf.pos.x = inputs.cursor.x;
        transf.pos.y = inputs.cursor.y;

        if (inputs.key[KEYS.W]) {
            sprite.animate(resources["sprite-sheet-enemy"]["animations"][0]);
        }
        if (inputs.key[KEYS.S]) {
            sprite.animate(resources["sprite-sheet-enemy"]["animations"][1]);
        }
        if (inputs.key[KEYS.A]) {
            sprite.animate(resources["sprite-sheet-enemy"]["animations"][2]);
        }
    }
}

export { Map };