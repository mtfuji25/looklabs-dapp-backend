import { ECS } from "../ecs/core/ecs";

import resources from "../resource.json";
import level from "../level.json";
import { inputs, KEYS } from "../inputs/inputs";

class Enemy {
    constructor(app) {
        this.app = app;
        this.entities = [];
        this.entity;
    }

    createEnemy() {

    }

    onAttach() {
        this.entity = ECS.createEntity(500, 500, ECS.ANIMSPRITE);
        let sprite = ECS.getComponent(this.entity, ECS.ANIMSPRITE);
        sprite.loadFromConfig(this.app, resources["enemy-sheet"]);
        sprite.addStage(this.app);
    }

    onServerMsg(msg) {
        // Get data from server here and dispatch
        // msg type should assume create update or delete
        // content should be the informations about the operation
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