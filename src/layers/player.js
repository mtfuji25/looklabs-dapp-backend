import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";

import resources from "../resource.json";

class PlayerLayer {
    constructor(app) {
        this.app = app;
        this.player;
        this.state = false;
    }

    onAttach() {
        this.player = ECS.createEntity(300, 400, ECS.ANIMSPRITE | ECS.RIGIDBODY);
        let sprite = ECS.getComponent(this.player, ECS.ANIMSPRITE);
        sprite.loadFromConfig(this.app, resources["sprite-sheet1"]);
        sprite.transform.pos.x = 500;
        sprite.transform.pos.y = 500;
        sprite.addStage(this.app);
    }

    onUpdate(deltaTime) {
        if (inputs.btn[BTNS.LEFT]) {
            let body = ECS.getComponent(this.player, ECS.RIGIDBODY);
            let posX = body.transform.pos.x;
            let posY = body.transform.pos.y;

            let difX = inputs.cursor.x - body.transform.pos.x;
            let difY = inputs.cursor.y - body.transform.pos.y;
            let lenght = Math.sqrt(difX ** 2 + difY ** 2);

            difX /= lenght;
            difY /= lenght;

            let factor = 10.0;
            difX *= factor;
            difY *= factor;

            body.mass = 5.0;

            body.addInpulse(difX, difY, 1);
        }
        if (inputs.btn[BTNS.RIGHT]) {
            let sprite = ECS.getComponent(this.player, ECS.ANIMSPRITE);
            sprite.animate(resources["sprite-sheet1"]["animations"][0]);
        }
    }
}

export { PlayerLayer };