import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";

import resources from "../resource.json";

class PlayerLayer {
    constructor(app) {
        this.app = app;
        this.player;
        this.state = false;
        this.jumping = false;
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
        this.jumping = ECS.getGlobal("jumping");

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
            ECS.setGlobal("jumping", true);
            let sprite = ECS.getComponent(this.player, ECS.ANIMSPRITE);
            sprite.animate(resources["sprite-sheet-player"]["animations"][2]);
            body.addInpulse(0.0, -7.0, 1);
            this.jumping = true;
        }
    }
}

export { PlayerLayer };