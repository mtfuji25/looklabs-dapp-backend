import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";

import resources from "../resource.json";

class Ui {
    constructor(app, statusFn, statusFn2, statusFn3, statusFn4) {
        this.app = app;
        this.statusFns = [ statusFn, statusFn2, statusFn3, statusFn4 ]
        this.lifeBar = {
            entity: {},
            value: 0
        };
        this.playerSelected = 0;
    }

    onAttach() {
        this.entity = ECS.createEntity(500, 500, ECS.ANIMSPRITE | ECS.RIGIDBODY);
        let sprite = ECS.getComponent(this.entity, ECS.ANIMSPRITE);
        sprite.loadFromConfig(this.app, resources["sprite-sheet-enemy"]);
        sprite.addStage(this.app);
        sprite.animate(resources["sprite-sheet-enemy"]["animations"][2]);
    }

    onUpdate(deltaTime) {
        let rigidibody = ECS.getComponent(this.entity, ECS.RIGIDBODY);

        if (inputs.btn[BTNS.LEFT]) {
            let difX = inputs.cursor.x - rigidibody.transform.pos.x;
            let difY = inputs.cursor.y - rigidibody.transform.pos.y;

            let length = Math.sqrt(difX ** 2 + difY ** 2);

            difX /= length;
            difY /= length;

            let factor = 1.5;

            difX *= factor;
            difY *= factor;

            rigidibody.addVel(difX, difY);
        }
    }
}

export { Ui };