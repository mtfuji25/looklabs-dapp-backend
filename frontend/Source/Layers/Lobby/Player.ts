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
    private listenerId: number = 0;

    // Application Related
    protected app: Application;
    protected res: Record<string, any>;

    // Web clients
    protected wsClient: WSClient;

    // Lobby level context
    private levelContext: LobbyLevelContext;

    private readonly idStyle: Partial<ITextStyle> = {
        fontFamily: "8-BIT WONDER",
        fontSize: 9,
        fill: 0xffffff,
        lineHeight: 12.6,
        align: "center",
        fontWeight: "400"
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

        this.listenerId = this.wsClient.addMsgListener((msg) =>
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
            animsprite.sprite.x = transform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX;
            animsprite.sprite.y = transform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY;

            animsprite.sprite.scale.x = 1.0 - this.levelContext.zoom;
            animsprite.sprite.scale.y = 1.0 - this.levelContext.zoom;  
            
            // Update text
            const id = player.id.getText();
            const idTransform = player.id.getTransform();

            id.text.x = idTransform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX;
            id.text.y = idTransform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY;

            // id.text.scale.x = 1.0 - this.levelContext.zoom;
            // id.text.scale.y = 1.0 - this.levelContext.zoom;

            // Update health bar
            const healt = player.health.getColoredRectangle();
            const healtTransform = player.health.getTransform();

            healt.sprite.x = healtTransform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX;
            healt.sprite.y = healtTransform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY;

            healt.sprite.scale.x = 1.0 - this.levelContext.zoom;
            healt.sprite.scale.y = 1.0 - this.levelContext.zoom;

            // Update health background
            const healtBg = player.healthBackground.getColoredRectangle();
            const healtBgTransform = player.healthBackground.getTransform();

            healtBg.sprite.x = healtBgTransform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX;
            healtBg.sprite.y = healtBgTransform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY;

            healtBg.sprite.scale.x = 1.0 - this.levelContext.zoom;
            healtBg.sprite.scale.y = 1.0 - this.levelContext.zoom;

            // Update health outline
            const healtOut = player.healthOutline.getColoredRectangle();
            const healtOutTransform  = player.healthOutline.getTransform();

            healtOut.sprite.x = healtOutTransform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX;
            healtOut.sprite.y = healtOutTransform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY;

            healtOut.sprite.scale.x = 1.0 - this.levelContext.zoom;
            healtOut.sprite.scale.y = 1.0 - this.levelContext.zoom;
        });
    }

    onDetach() {
        this.wsClient.remMsgListener(this.listenerId);

        this.self.destroy();
    }

    createEnemy(content: PlayerCommand) {
        const {id, pos} = content;

        const prevPlayer = this.players[id];

        if (prevPlayer) {
            delete this.players[id];
        }

        // Creates and stores entity
        const title = this.ecs.createEntity(pos.x, pos.y - 20, false); // No exact measurements for offset
        const entity = this.ecs.createEntity(pos.x, pos.y, false);
        const health = this.ecs.createEntity(pos.x, pos.y - 35, false);  //Should calculate offset later
        const healthOutline = this.ecs.createEntity(pos.x - 1, pos.y - 36, false);  //Should calculate offset later
        const healthBackground = this.ecs.createEntity(pos.x, pos.y - 35, false); //Should calculate offset later

        // Add id text
        title.addText(id.split('/')[1], this.idStyle);
        const titleText = title.getText();
        titleText.text.anchor.set(0.5);
        titleText.addStage(this.app);

        // Add healthBar
        healthOutline.addColoredRectangle(24, 6, 0x000000).addStage(this.app);
        healthBackground.addColoredRectangle(22, 4, 0x373232).addStage(this.app);
        health.addColoredRectangle(22,4, 0xF32D2D).addStage(this.app);
        
        // Add animsprite component
        const sprite = entity.addAnimSprite();
        sprite.loadFromConfig(this.app, this.res["enemy-sheet"]);
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
        
        const entity = this.players[id].entity;

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
        
        textTransform.pos.x = pos.x;
        textTransform.pos.y = pos.y - 16;

        healthOutlineTransform.pos.x = pos.x - 1;
        healthOutlineTransform.pos.y = pos.y - 36;

        healthBackgroundTransform.pos.x = pos.x;
        healthBackgroundTransform.pos.y = pos.y - 35;

        healthTransform.pos.x = pos.x;
        healthTransform.pos.y = pos.y - 35;


        if(action < 8 && action >= 0) {
            entitySprite.animate(this.res["enemy-sheet"]["animations"][action]);
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