import { ECS } from "../ecs/core/ecs";

import resources from "../resource.json";
import level from "../level.json";
import { inputs, KEYS } from "../inputs/inputs";
import * as util from "../utils/utils";

class Enemy {
    constructor(app) {
        this.app = app;
        this.entities = {};
        this.entity;
    }

    createEnemy(id, x, y) {
        let entity = ECS.createEntity(x, y, ECS.ANIMSPRITE);
        this.entities[id] = entity;
        let sprite = ECS.getComponent(entity, ECS.ANIMSPRITE);
        sprite.loadFromConfig(this.app, resources["enemy-sheet"]);
        sprite.addStage(this.app);
    }

    updateEnemy(id, action, pos) {
        let entity = this.entities[id];
        let sprite = ECS.getComponent(entity, ECS.ANIMSPRITE);
        let transform = ECS.getComponent(entity, ECS.TRANSFORM);
        transform.pos.x = pos.x;
        transform.pos.y = pos.y;

        switch (action) {
            case 0:
                sprite.animate(resources["enemy-sheet"]["animations"][0]);
                break;
            case 1:
                sprite.animate(resources["enemy-sheet"]["animations"][1]);
                break;
            case 2:
                sprite.animate(resources["enemy-sheet"]["animations"][2]);
                break;
            case 3:
                sprite.animate(resources["enemy-sheet"]["animations"][3]);
                break;
            case 4:
                sprite.animate(resources["enemy-sheet"]["animations"][4]);
                break;
            case 5:
                sprite.animate(resources["enemy-sheet"]["animations"][5]);
                break;
            case 6:
                sprite.animate(resources["enemy-sheet"]["animations"][6]);
                break;
            case 7:
                sprite.animate(resources["enemy-sheet"]["animations"][7]);
                break;
        }
    }

    deleteEnemy(id) {
        let sprite = ECS.getComponent(this.entities[id], ECS.ANIMSPRITE);
        sprite.removeStage(this.app);
        ECS.deleteEntity(this.entities[id]);
    }

    onAttach() {
        this.entity = ECS.createEntity(500, 500, ECS.ANIMSPRITE);
        let sprite = ECS.getComponent(this.entity, ECS.ANIMSPRITE);
        sprite.loadFromConfig(this.app, resources["enemy-sheet"]);
        sprite.addStage(this.app);
    }

    onServerMsg(msg) {
        
    }

    onUpdate(deltaTime) {
        let sprite = ECS.getComponent(this.entity, ECS.ANIMSPRITE);
        if (inputs.key[KEYS.W]) {
            sprite.animate(resources["enemy-sheet"]["animations"][6]);
        }
        if (inputs.key[KEYS.S]) {
            sprite.animate(resources["enemy-sheet"]["animations"][7]);
        }
        if (inputs.key[KEYS.A]) {
            sprite.animate(resources["enemy-sheet"]["animations"][5]);
        }
        if (inputs.key[KEYS.D]) {
            sprite.animate(resources["enemy-sheet"]["animations"][4]);
        }
    }
}

export { Enemy };