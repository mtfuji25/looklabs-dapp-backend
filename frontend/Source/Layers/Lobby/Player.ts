// Import layer
import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

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
import { msgTypes, PlayerCommand } from "../../Clients/Interfaces";

interface Player {
    entity: Entity;
    health: Entity;
    healthOutline: Entity;
    healthBackground: Entity;
    id: Entity;
}

class PlayerLayer extends Layer {
    private players: Record<string, Player> = {};
    // Entites storage

    // Listener id
    private listener: string;

    // Application Related
    protected app: Application;
    protected res: Record<string, any>;

    // Web clients
    protected wsClient: WSClient;

    // Lobby level context
    private levelContext: LobbyLevelContext;

    private readonly idStyle: Partial<ITextStyle> = {
        fontFamily: "8-BIT WONDER",
        fontSize: "10px",
        fill: 0xffffff,
        align: "center",
        fontWeight: "800",
        stroke: "#000000",
        strokeThickness: 4,
    }

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

        this.listener = this.wsClient.addMsgListener((msg) =>
            this.onServerMsg(msg)
        );
    }

    onAttach() {}

    onUpdate(deltaTime: number) {
        Object.values(this.players).map((player) => {
            const transform = player.entity.getTransform();
            const animsprite = player.entity.getAnimSprite();

            // Calculates offsets to fix view
            const centerFactorX = (transform.pos.x - CONTAINER_DIM / 2.0) / (CONTAINER_DIM / 2.0);
            const centerFactorY = (transform.pos.y - CONTAINER_DIM / 2.0) / (CONTAINER_DIM / 2.0);
            const fixFactorX = (CONTAINER_DIM - CONTAINER_DIM * (1 - this.levelContext.zoom)) / 2.0;
            const fixFactorY = (CONTAINER_DIM - CONTAINER_DIM * (1 - this.levelContext.zoom)) / 2.0;

            // Fix the position for the player
            animsprite.sprite.x = Math.floor(transform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            animsprite.sprite.y = Math.floor(transform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY);

            animsprite.sprite.scale.x = (1.0 - this.levelContext.zoom);
            animsprite.sprite.scale.y = (1.0 - this.levelContext.zoom);  
            
            // Update text
            const id = player.id.getText();
            const idTransform = player.id.getTransform();

            id.text.x = Math.floor(idTransform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            id.text.y = Math.floor(idTransform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY);
            
            // id.text.scale.x = 1.0 - this.levelContext.zoom;
            // id.text.scale.y = 1.0 - this.levelContext.zoom;

            // Update health bar
            const healt = player.health.getColoredRectangle();
            const healtTransform = player.health.getTransform();

            healt.sprite.x = Math.floor(healtTransform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            healt.sprite.y = Math.floor(healtTransform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY);

            healt.sprite.scale.x = 1.0 - this.levelContext.zoom;
            healt.sprite.scale.y = 1.0 - this.levelContext.zoom;

            // Update health background
            const healtBg = player.healthBackground.getColoredRectangle();
            const healtBgTransform = player.healthBackground.getTransform();

            healtBg.sprite.x = Math.floor(healtBgTransform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            healtBg.sprite.y = Math.floor(healtBgTransform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY);

            healtBg.sprite.scale.x = 1.0 - this.levelContext.zoom;
            healtBg.sprite.scale.y = 1.0 - this.levelContext.zoom;

            // Update health outline
            const healtOut = player.healthOutline.getColoredRectangle();
            const healtOutTransform  = player.healthOutline.getTransform();

            healtOut.sprite.x = Math.floor(healtOutTransform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            healtOut.sprite.y = Math.floor(healtOutTransform.pos.y  + this.levelContext.offsetY - fixFactorY * centerFactorY);

            healtOut.sprite.scale.x = 1.0 - this.levelContext.zoom;
            healtOut.sprite.scale.y = 1.0 - this.levelContext.zoom;
        });
    }

    onDetach() {
        this.wsClient.remMsgListener(this.listener);

        this.self.destroy();
    }

    createEnemy(content: PlayerCommand) {
        const {id, pos} = content;

        const prevPlayer = this.players[id];

        if (prevPlayer) {
            delete this.players[id];
        }

        const splitId = id.split('/')[1];

        // Creates and stores entity
        const title = this.ecs.createEntity(pos.x - (splitId.length - 1) * 0.2, pos.y - 20, false);  
        const entity = this.ecs.createEntity(pos.x, pos.y, false);
        const health = this.ecs.createEntity(pos.x - 12, pos.y - 35, false);
        const healthOutline = this.ecs.createEntity(pos.x - 13, pos.y - 36, false);
        const healthBackground = this.ecs.createEntity(pos.x - 12, pos.y - 35, false);

        // Add id text
        title.addText(splitId, this.idStyle);
        const titleText = title.getText();
        titleText.text.anchor.set(0.5);
        titleText.addStage(this.app);
        
        // Add healthBar
        healthOutline.addColoredRectangle(24, 6, 0x000000).addStage(this.app);
        healthBackground.addColoredRectangle(22, 4, 0x373232).addStage(this.app);
        health.addColoredRectangle(22,4, 0xF32D2D).addStage(this.app);
        
        // Add animsprite component
        const sprite = entity.addAnimSprite();
        const type = Math.floor(Math.random() * 4);
        switch (type) {
            case 0:
                sprite.loadFromConfig(this.app, this.res["wolf-sheet"]);
                break;
            case 1:
                sprite.loadFromConfig(this.app, this.res["bat-sheet"]);
                break;
            case 2:
                sprite.loadFromConfig(this.app, this.res["snake-sheet"]);
                break;
            case 3:
                sprite.loadFromConfig(this.app, this.res["chicken-sheet"]);
                break;
            default:
                sprite.loadFromConfig(this.app, this.res["wolf-sheet"]);
                break;
        }
        
        sprite.addStage(this.app);

        this.players[id] = {
            entity: entity,
            id: title,
            healthOutline: healthOutline,
            healthBackground: healthBackground,
            health: health
        };
    }

    updateEnemy(command: PlayerCommand) {
        const { id, pos, action, health, maxHealth } = command;
        
        pos.x = Math.floor(pos.x);
        pos.y = Math.floor(pos.y);

        if (!this.players) {
            this.createEnemy(command);
        }

        const entity = this.players[id].entity;
        const splitId = id.split('/')[1];

        if (!entity) {
            this.createEnemy(command);
        }

        const textTransform = this.players[id].id.getTransform();
        const healthOutlineTransform = this.players[id].healthOutline.getTransform();
        const healthBackgroundTransform = this.players[id].healthBackground.getTransform();
        const healthBar = this.players[id].health;
        const healthTransform = healthBar.getTransform();
        const entitySprite = entity.getAnimSprite();
        const entityTransform = entity.getTransform();

        const lifeRecSize = Math.floor((health / maxHealth) * 22);
        const lifeRectangle = healthBar.getColoredRectangle();
        lifeRectangle.setSize(lifeRecSize, 4);

        // Set all positions
        entityTransform.pos.x = pos.x;
        entityTransform.pos.y = pos.y;
        
        textTransform.pos.x = pos.x - (splitId.length - 1) * 0.2;
        textTransform.pos.y = pos.y - 20;

        healthOutlineTransform.pos.x = pos.x - 13;
        healthOutlineTransform.pos.y = pos.y - 36;

        healthBackgroundTransform.pos.x = pos.x - 12;
        healthBackgroundTransform.pos.y = pos.y - 35;

        healthTransform.pos.x = pos.x - 12;
        healthTransform.pos.y = pos.y - 35;

        if (health <= 0) {
            if (action == 0 || action == 4) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][4]);
            }
            if (action == 1 || action == 5) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][5]);
            }
        } else {
            if (action == 4) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][0]);
            }
            if (action == 5) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][1]);
            }
            if (action == 0) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][2]);
            }
            if (action == 1) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][3]);
            }
            if (action == 2 || action == 3 || action == 6 || action == 7) {
                if (Math.random() < 0.5) {
                    entitySprite.animate(this.res["wolf-sheet"]["animations"][0]);
                } else {
                    entitySprite.animate(this.res["wolf-sheet"]["animations"][1]);
                }
            }
        }
    }

    deleteEnemy(command: PlayerCommand) {
        const { id } = command;

        this.players[id].id.destroy();
        this.players[id].health.destroy();
        this.players[id].healthOutline.destroy();
        this.players[id].healthBackground.destroy();
        this.players[id].entity.destroy();
        delete this.players[id];
    }

    onServerMsg(msg: ServerResponse) {
        let content;
        if (msg.content.msgType == msgTypes.enemy) {
            content = msg.content as PlayerCommand;
        } else {
            return false;
        }

        const { x, y } = wordToView(new Vec2(content.pos.x, content.pos.y))
        content.pos.x = x;
        content.pos.y = y;

        console.log(content);

        switch (content.type) {
            case "create":
                this.createEnemy(content);
                break;
            case "update":
                this.updateEnemy(content);
                break;
            case "delete":
                this.deleteEnemy(content);
                break;
        }

        // Does not handle the event
        return false;
    }
}

export { PlayerLayer };