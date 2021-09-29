
import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";

import resources from "../resource.json";

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

        // for (let i = 0; i < this.rows; ++i) {
        //     for (let j = 0; j < this.colums; ++j) {
        //         let entity = ECS.createEntity(x, y, ECS.SPRITE);
        //         this.map.push(entity);
        //         let sprite = ECS.getComponent(entity, ECS.SPRITE);
        //         sprite.setImg(this.app.loader.resources[test[counter]]);
        //         sprite.addStage(this.app);
        //         x += 100;
        //         if (counter == 4)

        //     }
        //     y += 100;
        // }
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