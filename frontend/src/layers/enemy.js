import { ECS } from "../ecs/core/ecs";

import resources from "../resource.json";
import { wordToView } from "../utils/utils";

class Enemy {
    constructor(app, ws) {
        this.app = app;
        this.connection = ws;

        this.entities = {};
        this.props = {
            width: this.app.view.width,
            height: this.app.view.height,
        };

        this.listener = ws.addListener(this);
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
    }

    onServerMsg(msg) {
        console.log("Hey, msg");
        let pos;
        switch (msg.type) {
            case "create-enemy":
                pos = wordToView({ x: msg.content.pos.x, y: msg.content.pos.y }, this.props);
                console.log(pos)
                this.createEnemy(msg.content.id, pos.x, pos.y);
                break;
            case "update-enemy":
                pos = wordToView({ x: msg.content.pos.x, y: msg.content.pos.y }, this.props);
                this.updateEnemy(msg.content.id, msg.content.action, pos);
                break;
            case "delete-enemy":
                this.deleteEnemy(msg.content.id);
                break;
        }
    }

    onUpdate(deltaTime) {
    }
}

export { Enemy };