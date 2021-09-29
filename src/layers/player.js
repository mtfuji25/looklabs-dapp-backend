import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";


class PlayerLayer {
    constructor(app) {
        this.app = app;
        this.player;
    }

    onAttach() {
        this.player = ECS.createEntity(300, 400, ECS.SPRITE | ECS.RIGIDBODY);
        let sprite = ECS.getComponent(this.player, ECS.SPRITE);
        sprite.setImg(this.app.loader.resources["bw"]);
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

            let factor = 1.0;
            difX *= factor;
            difY *= factor;

            body.addVel(difX, difY);
        }
    }
}

export { PlayerLayer };