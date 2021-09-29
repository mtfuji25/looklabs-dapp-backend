import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";

import resources from "../resource.json";

class PlayerLayer {
    constructor(app) {
        this.app = app;
        this.player;
        this.state = false;
        this.jumping = false;
        this.doubleJumping = false;
    }

    setRec() {
        let rec = ECS.getComponent(this.player, ECS.RECTANGLE);
        rec.width = 100;
        rec.height = 100;
        rec.needCheck = true;
    }

    onAttach() {
        this.player = ECS.createEntity(300, 400, ECS.ANIMSPRITE | ECS.RIGIDBODY | ECS.RECTANGLE);
        let sprite = ECS.getComponent(this.player, ECS.ANIMSPRITE);
        sprite.loadFromConfig(this.app, resources["sprite-sheet-player"]);
        sprite.addStage(this.app);
        let body = ECS.getComponent(this.player, ECS.RIGIDBODY);
        body.mass = 5.0;
        this.setRec();
    }

    onUpdate(deltaTime) {
        if (inputs.key[KEYS.D]) {
            let transform = ECS.getComponent(this.player, ECS.TRANSFORM);
            transform.pos.x += 5;
            let sprite = ECS.getComponent(this.player, ECS.ANIMSPRITE);
            sprite.animate(resources["sprite-sheet-player"]["animations"][1]);
        }
        if (inputs.key[KEYS.A]) {
            let transform = ECS.getComponent(this.player, ECS.TRANSFORM);
            transform.pos.x -= 5;
            let sprite = ECS.getComponent(this.player, ECS.ANIMSPRITE);
            sprite.animate(resources["sprite-sheet-player"]["animations"][0]);
        }
        if (inputs.key[KEYS.SPACE]) {
            let body = ECS.getComponent(this.player, ECS.RIGIDBODY);
            if (!this.jumping) {
                body.addInpulse(0.0, -30.0, 1);
                this.jumping = true;
            } else if (this.jumping && (!this.doubleJumping)) {
                body.addInpulse(0.0, -30.0, 1);
                this.doubleJumping = true;
            }
        }

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