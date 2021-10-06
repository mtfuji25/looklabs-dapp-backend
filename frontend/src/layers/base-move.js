import { ECS } from "../ecs/core/ecs";
import { inputs, KEYS, BTNS } from "../inputs/inputs";

class BaseMove {
    constructor(app) {
        this.app = app;
        this.xOffset = 0;
    }

    onAttach() {
        ECS.setGlobal("app-width", this.app.view.width);
        ECS.setGlobal("app-height", this.app.view.height);
    }

    onUpdate(deltaTime) {
        if (inputs.key[KEYS.A]) {
            this.xOffset += 1;
            ECS.setGlobal("xOffset", this.xOffset);
        } else if (inputs.key[KEYS.D]) {
            this.xOffset -= 1;
            ECS.setGlobal("xOffset", this.xOffset);
        }
    }
}

export { BaseMove };