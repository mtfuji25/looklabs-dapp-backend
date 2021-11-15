// Import layer
import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application } from "pixi.js";

// Web client imports
import { ServerResponse, WSClient } from "../../Clients/WebSocket";

// Ecs imports
import { ECS, Entity } from "../../Core/Ecs/Core/Ecs";

// Utils imports
import { Vec2 } from "../../Utils/Math";
import { wordToView } from "../../Utils/Views";

// Constants
import { CONTAINER_DIM } from "../../Constants/Constants";

// Current Lobby level context
import { LobbyLevelContext } from "../../Levels/Lobby";


class PlayerLayer extends Layer {
    // Entites storage
    private entities: Record<number, Entity> = {};

    // Listener id
    private listenerId: number = 0;

    // Application Related
    protected app: Application;
    protected res: Record<string, any>;

    // Web clients
    protected wsClient: WSClient;

    // Lobby level context
    private levelContext: LobbyLevelContext;

    constructor(
        ecs: ECS,
        levelContext: LobbyLevelContext,
        app: Application,
        wsClient: WSClient,
        resource: Record<string, any>
    ) {
        super("PlayerController", ecs);

        this.app = app;
        this.res = resource;
        this.wsClient = wsClient;
        this.levelContext = levelContext;

        this.listenerId = this.wsClient.addMsgListener((msg) =>
            this.onServerMsg(msg)
        );
    }

    onAttach() {}

    onUpdate(deltaTime: number) {
        Object.values(this.entities).map((entity) => {
            const transform = entity.getTransform();

            // Calculates offsets to fix view
            const centerFactorX = (transform.pos.x - CONTAINER_DIM / 2.0) / (CONTAINER_DIM / 2.0);
            const centerFactorY = (transform.pos.y - CONTAINER_DIM / 2.0) / (CONTAINER_DIM / 2.0);
            const fixFactorX = (CONTAINER_DIM - CONTAINER_DIM * (1 - this.levelContext.zoom)) / 2.0;
            const fixFactorY = (CONTAINER_DIM - CONTAINER_DIM * (1 - this.levelContext.zoom)) / 2.0;

            // Fix the position
            transform.pos.x = transform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX;
            transform.pos.y = transform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY;

            // Set the scale
            transform.setScale(
                1.0 - this.levelContext.zoom,
                1.0 - this.levelContext.zoom
            );
        });
    }

    onDetach() {
        this.wsClient.remMsgListener(this.listenerId);

        this.self.destroy();
    }

    createEnemy(id: number, pos: Vec2) {
        // Creates and stores entity
        const entity = this.ecs.createEntity(pos.x, pos.y);
        this.entities[id] = entity;

        // Add animsprite component
        const sprite = entity.addAnimSprite();
        sprite.loadFromConfig(this.app, this.res["enemy-sheet"]);
        sprite.addStage(this.app);
    }

    updateEnemy(id: number, action: number, pos: Vec2) {
        const entity = this.entities[id];
        const sprite = entity.getAnimSprite();
        const transform = entity.getTransform();

        transform.pos.x = pos.x;
        transform.pos.y = pos.y;

        switch (action) {
            case 0:
                sprite.animate(this.res["enemy-sheet"]["animations"][0]);
                break;
            case 1:
                sprite.animate(this.res["enemy-sheet"]["animations"][1]);
                break;
            case 2:
                sprite.animate(this.res["enemy-sheet"]["animations"][2]);
                break;
            case 3:
                sprite.animate(this.res["enemy-sheet"]["animations"][3]);
                break;
            case 4:
                sprite.animate(this.res["enemy-sheet"]["animations"][4]);
                break;
            case 5:
                sprite.animate(this.res["enemy-sheet"]["animations"][5]);
                break;
            case 6:
                sprite.animate(this.res["enemy-sheet"]["animations"][6]);
                break;
            case 7:
                sprite.animate(this.res["enemy-sheet"]["animations"][7]);
                break;
        }
    }

    deleteEnemy(id: number) {
        this.entities[id].destroy();
    }

    onServerMsg(msg: ServerResponse) {
        switch (msg.content.type) {
            case "create-enemy":
                this.createEnemy(
                    msg.content.id,
                    wordToView(new Vec2(msg.content.pos.x, msg.content.pos.y))
                );
                break;
            case "update-enemy":
                this.updateEnemy(
                    msg.content.id,
                    msg.content.action,
                    wordToView(new Vec2(msg.content.pos.x, msg.content.pos.y))
                );
                break;
            case "delete-enemy":
                this.deleteEnemy(msg.content.id);
                break;
        }

        // Does not handle the event
        return false;
    }
}

export { PlayerLayer };