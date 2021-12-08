// Import layer
import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

// Web client imports
import { WSClient } from "../../Clients/WebSocket";

// Ecs imports
import { ECS, Entity } from "../../Core/Ecs/Core/Ecs";

// Utils imports
import { Vec2 } from "../../Utils/Math";
import { wordToView } from "../../Utils/Views";

// Constants
import { CONTAINER_DIM_X, CONTAINER_DIM_Y } from "../../Constants/Constants";

// Current Lobby level context
import { LobbyLevelContext } from "../../Levels/Lobby";
import { Listener, msgTypes, PlayerCommand, ServerMsg } from "../../Clients/Interfaces";

import { Container } from "pixi.js";
import { StrapiClient } from "../../Clients/Strapi";

interface Player {
    entity: Entity;
    health: Entity;
    healthOutline: Entity;
    healthBackground: Entity;
    id: Entity;
    animSlot1: Entity;
    animSlot2: Entity;
    animSlot3: Entity;
}

class PlayerLayer extends Layer {
    // Entites storage
    private players: Record<string, Player> = {};

    // Listener id
    private listener: Listener;

    // Application Related
    protected app: Application;
    protected res: Record<string, any>;

    // Web clients
    protected wsClient: WSClient;
    protected strapiClient: StrapiClient;

    // Playher container
    private container: Container;

    // Lobby level context
    private levelContext: LobbyLevelContext;

    static lastGamePlayerNames: Record<string, string> = {};

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
        strapiClient: StrapiClient,
        resource: Record<string, any>
    ) {
        super("PlayerController", ecs);

        this.app = app;
        this.res = resource;
        this.wsClient = wsClient;
        this.levelContext = levelContext;

        this.listener = this.wsClient.addListener("enemy", (msg) =>
            this.onServerMsg(msg)
        );

        this.container = new Container();
    }

    onAttach() {
        this.app.stage.addChild(this.container);
    }

    onUpdate(deltaTime: number) {
        Object.values(this.players).map((player) => {
            const transform = player.entity.getTransform();
            const animsprite = player.entity.getAnimSprite();

            // Calculates offsets to fix view
            const centerFactorX = (transform.pos.x - CONTAINER_DIM_X / 2.0) / (CONTAINER_DIM_X / 2.0);
            const centerFactorY = (transform.pos.y - CONTAINER_DIM_Y / 2.0) / (CONTAINER_DIM_Y / 2.0);
            const fixFactorX = (CONTAINER_DIM_X - CONTAINER_DIM_X * (1 - this.levelContext.zoom)) / 2.0;
            const fixFactorY = (CONTAINER_DIM_Y - CONTAINER_DIM_Y * (1 - this.levelContext.zoom)) / 2.0;

            // Fix the position for the player
            animsprite.sprite.x = Math.floor(transform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            animsprite.sprite.y = Math.floor(transform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY);

            animsprite.sprite.scale.x = (1.0 - this.levelContext.zoom);
            animsprite.sprite.scale.y = (1.0 - this.levelContext.zoom);  
            
            // Update animations slots
            const animSpriteSlot1 = player.animSlot1.getAnimSprite();
            const animSpriteSlot2 = player.animSlot2.getAnimSprite();
            const animSpriteSlot3 = player.animSlot3.getAnimSprite();

            animSpriteSlot3.sprite.x = Math.floor(transform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            animSpriteSlot3.sprite.y = Math.floor(transform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY);

            animSpriteSlot3.sprite.scale.x = (1.0 - this.levelContext.zoom);
            animSpriteSlot3.sprite.scale.y = (1.0 - this.levelContext.zoom);

            animSpriteSlot2.sprite.x = Math.floor(transform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            animSpriteSlot2.sprite.y = Math.floor(transform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY) - 32;

            animSpriteSlot2.sprite.scale.x = (1.0 - this.levelContext.zoom);
            animSpriteSlot2.sprite.scale.y = (1.0 - this.levelContext.zoom);

            animSpriteSlot1.sprite.x = Math.floor(transform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            animSpriteSlot1.sprite.y = Math.floor(transform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY) -64;

            animSpriteSlot1.sprite.scale.x = (1.0 - this.levelContext.zoom);
            animSpriteSlot1.sprite.scale.y = (1.0 - this.levelContext.zoom); 

            // Update text
            const id = player.id.getText();
            const idTransform = player.id.getTransform();

            id.text.x = Math.floor(idTransform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            id.text.y = Math.floor(idTransform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY);
            
            id.text.scale.x = 1.0 - (this.levelContext.zoom / 2.0);
            id.text.scale.y = 1.0 - (this.levelContext.zoom / 2.0);

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
        this.listener.destroy();

        this.self.destroy();
    }

    createEnemy(content: PlayerCommand) {
    
        const { id, pos, char_class, name } = content;

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

        // Animations slots
        const animSlot1 = this.ecs.createEntity(pos.x, pos.y - 64, false);
        const animSlot2 = this.ecs.createEntity(pos.x, pos.y - 32, false);
        const animSlot3 = this.ecs.createEntity(pos.x, pos.y, false);

        const animSpriteSlot1 = animSlot1.addAnimSprite();
        const animSpriteSlot2 = animSlot2.addAnimSprite();
        const animSpriteSlot3 = animSlot3.addAnimSprite();

        animSpriteSlot1.loadFromConfig(this.app, this.res["overlay-sheet"]);
        animSpriteSlot2.loadFromConfig(this.app, this.res["overlay-sheet"]);
        animSpriteSlot3.loadFromConfig(this.app, this.res["overlay-sheet"]);

        animSpriteSlot1.sprite.visible = false;
        animSpriteSlot2.sprite.visible = false;
        animSpriteSlot3.sprite.visible = false;

        // Add id text
        title.addText(splitId, this.idStyle);
        const titleText = title.getText();
        titleText.text.anchor.set(0.5);
        titleText.addStage(this.container);
        
        // Add animsprite component
        const sprite = entity.addAnimSprite();

        console.log("ID: ", id, " Nome: ", name);
        PlayerLayer.lastGamePlayerNames[id] = name;

        switch (char_class) {
            case "Avian":
                sprite.loadFromConfig(this.app, this.res["chicken-sheet"]);
                break;
            case "Canine":
                sprite.loadFromConfig(this.app, this.res["wolf-sheet"]); 
                break;
            case "Insectoid":
                sprite.loadFromConfig(this.app, this.res["bat-sheet"]);
                break;
            case 'Serpentine':
                sprite.loadFromConfig(this.app, this.res["snake-sheet"]);
                break;
            default:
                sprite.loadFromConfig(this.app, this.res["bat-sheet"]);
                break;
        }

        sprite.addStage(this.container);

        animSpriteSlot1.addStage(this.container);
        animSpriteSlot2.addStage(this.container);
        animSpriteSlot3.addStage(this.container);

        // Add healthBar
        healthOutline.addColoredRectangle(24, 6, 0x000000).addStage(this.container);
        healthBackground.addColoredRectangle(22, 4, 0x373232).addStage(this.container);
        health.addColoredRectangle(22,4, 0xF32D2D).addStage(this.container);

        this.players[id] = {
            entity: entity,
            id: title,
            healthOutline: healthOutline,
            healthBackground: healthBackground,
            health: health,
            animSlot1: animSlot1,
            animSlot2: animSlot2,
            animSlot3: animSlot3
        };
    }

    updateEnemy(command: PlayerCommand) {
        const { id, pos, action, health, maxHealth } = command;
        
        pos.x = Math.floor(pos.x);
        pos.y = Math.floor(pos.y);

        if (!this.players[id]) {
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

        const animSpriteSlot1 = this.players[id].animSlot1.getAnimSprite();
        const animSpriteSlot2 = this.players[id].animSlot2.getAnimSprite();
        const animSpriteSlot3 = this.players[id].animSlot3.getAnimSprite();

        const lifeRecSize = Math.floor((health / maxHealth) * 22);
        const lifeRectangle = healthBar.getColoredRectangle();
        lifeRectangle.setSize(lifeRecSize, 4);

        // Set all positions
        entityTransform.pos.x = Math.floor(pos.x);
        entityTransform.pos.y = Math.floor(pos.y);
        
        textTransform.pos.x = Math.floor(pos.x - (splitId.length - 1) * 0.2);
        textTransform.pos.y = Math.floor(pos.y - 20);

        healthOutlineTransform.pos.x = Math.floor(pos.x - 13);
        healthOutlineTransform.pos.y = Math.floor(pos.y - 36);

        healthBackgroundTransform.pos.x = Math.floor(pos.x - 12);
        healthBackgroundTransform.pos.y = Math.floor(pos.y - 35);

        healthTransform.pos.x = Math.floor(pos.x - 12);
        healthTransform.pos.y = Math.floor(pos.y - 35);

        // if else generator
        if (health <= 0) {
            if (action == 0 || action == 4) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][4]);
            }
            if (action == 1 || action == 5) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][5]);
            }
        } else {
            //
            // First set
            //
            if (action == 4) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][0]);

                animSpriteSlot1.sprite.visible = false;
                animSpriteSlot2.sprite.visible = false;
                animSpriteSlot3.sprite.visible = false;
            }
            // critical R
            if (action == 14) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][0]);
                animSpriteSlot1.forceAnimate(this.res["overlay-sheet"]["animations"][3]);
                animSpriteSlot2.forceAnimate(this.res["overlay-sheet"]["animations"][4]);
                animSpriteSlot3.forceAnimate(this.res["overlay-sheet"]["animations"][5]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }
            // healing
            if (action == 24) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][0]);
                animSpriteSlot1.animate(this.res["overlay-sheet"]["animations"][9]);
                animSpriteSlot2.animate(this.res["overlay-sheet"]["animations"][10]);
                animSpriteSlot3.animate(this.res["overlay-sheet"]["animations"][11]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }

            //
            // Second set
            //
            if (action == 5) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][1]);

                animSpriteSlot1.sprite.visible = false;
                animSpriteSlot2.sprite.visible = false;
                animSpriteSlot3.sprite.visible = false;
            }
            // critical L
            if (action == 15) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][1]);
                animSpriteSlot1.forceAnimate(this.res["overlay-sheet"]["animations"][6]);
                animSpriteSlot2.forceAnimate(this.res["overlay-sheet"]["animations"][7]);
                animSpriteSlot3.forceAnimate(this.res["overlay-sheet"]["animations"][8]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }
            // healing
            if (action == 25) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][1]);
                animSpriteSlot1.animate(this.res["overlay-sheet"]["animations"][9]);
                animSpriteSlot2.animate(this.res["overlay-sheet"]["animations"][10]);
                animSpriteSlot3.animate(this.res["overlay-sheet"]["animations"][11]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }

            //
            // Third set
            //
            if (action == 0) {
                entitySprite.forceAnimate(this.res["wolf-sheet"]["animations"][2]);

                animSpriteSlot1.sprite.visible = false;
                animSpriteSlot2.sprite.visible = false;
                animSpriteSlot3.sprite.visible = false;
            }
            // critical R
            if (action == 10) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][2]);
                animSpriteSlot1.forceAnimate(this.res["overlay-sheet"]["animations"][3]);
                animSpriteSlot2.forceAnimate(this.res["overlay-sheet"]["animations"][4]);
                animSpriteSlot3.forceAnimate(this.res["overlay-sheet"]["animations"][5]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }
            // Healing
            if (action == 20) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][2]);
                animSpriteSlot1.animate(this.res["overlay-sheet"]["animations"][9]);
                animSpriteSlot2.animate(this.res["overlay-sheet"]["animations"][10]);
                animSpriteSlot3.animate(this.res["overlay-sheet"]["animations"][11]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }

            // Fourth set
            if (action == 1) {
                entitySprite.forceAnimate(this.res["wolf-sheet"]["animations"][3]);

                animSpriteSlot1.sprite.visible = false;
                animSpriteSlot2.sprite.visible = false;
                animSpriteSlot3.sprite.visible = false;
            }
            // critical L
            if (action == 11) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][3]);
                animSpriteSlot1.forceAnimate(this.res["overlay-sheet"]["animations"][6]);
                animSpriteSlot2.forceAnimate(this.res["overlay-sheet"]["animations"][7]);
                animSpriteSlot3.forceAnimate(this.res["overlay-sheet"]["animations"][8]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }
            // Healing
            if (action == 21) {
                entitySprite.animate(this.res["wolf-sheet"]["animations"][3]);
                animSpriteSlot1.animate(this.res["overlay-sheet"]["animations"][9]);
                animSpriteSlot2.animate(this.res["overlay-sheet"]["animations"][10]);
                animSpriteSlot3.animate(this.res["overlay-sheet"]["animations"][11]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }
            
            //
            // Fifth set
            //
            if (action == 2 || action == 3) {
                if (Math.random() < 0.5) {
                    entitySprite.forceAnimate(this.res["wolf-sheet"]["animations"][2]);
                } else {
                    entitySprite.forceAnimate(this.res["wolf-sheet"]["animations"][3]);
                }
                animSpriteSlot1.sprite.visible = false;
                animSpriteSlot2.sprite.visible = false;
                animSpriteSlot3.sprite.visible = false;
            }
            // Critical
            if (action == 12 || action == 13) {
                if (Math.random() < 0.5) {
                    // Right
                    entitySprite.forceAnimate(this.res["wolf-sheet"]["animations"][2]);
                    animSpriteSlot1.forceAnimate(this.res["overlay-sheet"]["animations"][3]);
                    animSpriteSlot2.forceAnimate(this.res["overlay-sheet"]["animations"][4]);
                    animSpriteSlot3.forceAnimate(this.res["overlay-sheet"]["animations"][5]);
                } else {
                    // Left
                    entitySprite.forceAnimate(this.res["wolf-sheet"]["animations"][3]);
                    animSpriteSlot1.forceAnimate(this.res["overlay-sheet"]["animations"][6]);
                    animSpriteSlot2.forceAnimate(this.res["overlay-sheet"]["animations"][7]);
                    animSpriteSlot3.forceAnimate(this.res["overlay-sheet"]["animations"][8]);
                }
                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }
            // Healing
            if (action == 22 || action == 23) {
                if (Math.random() < 0.5) {
                    entitySprite.forceAnimate(this.res["wolf-sheet"]["animations"][2]);
                } else {
                    entitySprite.forceAnimate(this.res["wolf-sheet"]["animations"][3]);
                }
                animSpriteSlot1.animate(this.res["overlay-sheet"]["animations"][9]);
                animSpriteSlot2.animate(this.res["overlay-sheet"]["animations"][10]);
                animSpriteSlot3.animate(this.res["overlay-sheet"]["animations"][11]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }

            //
            // Sixth set
            //
            if (action == 6 || action == 7) {
                if (Math.random() < 0.5) {
                    entitySprite.animate(this.res["wolf-sheet"]["animations"][0]);
                } else {
                    entitySprite.animate(this.res["wolf-sheet"]["animations"][1]);
                }
                animSpriteSlot1.sprite.visible = false;
                animSpriteSlot2.sprite.visible = false;
                animSpriteSlot3.sprite.visible = false;
            }
            // Critical
            if (action == 16 || action == 17) {
                if (Math.random() < 0.5) {
                    // Right
                    entitySprite.animate(this.res["wolf-sheet"]["animations"][0]);
                    animSpriteSlot1.forceAnimate(this.res["overlay-sheet"]["animations"][3]);
                    animSpriteSlot2.forceAnimate(this.res["overlay-sheet"]["animations"][4]);
                    animSpriteSlot3.forceAnimate(this.res["overlay-sheet"]["animations"][5]);
                } else {
                    // Left
                    entitySprite.animate(this.res["wolf-sheet"]["animations"][1]);
                    animSpriteSlot1.forceAnimate(this.res["overlay-sheet"]["animations"][6]);
                    animSpriteSlot2.forceAnimate(this.res["overlay-sheet"]["animations"][7]);
                    animSpriteSlot3.forceAnimate(this.res["overlay-sheet"]["animations"][8]);
                }

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }
            // Healing
            if (action == 26 || action == 27) {
                if (Math.random() < 0.5) {
                    entitySprite.animate(this.res["wolf-sheet"]["animations"][0]);
                } else {
                    entitySprite.animate(this.res["wolf-sheet"]["animations"][1]);
                }
                animSpriteSlot1.animate(this.res["overlay-sheet"]["animations"][9]);
                animSpriteSlot2.animate(this.res["overlay-sheet"]["animations"][10]);
                animSpriteSlot3.animate(this.res["overlay-sheet"]["animations"][11]);

                animSpriteSlot1.sprite.visible = true;
                animSpriteSlot2.sprite.visible = true;
                animSpriteSlot3.sprite.visible = true;
            }
        }
    }

    deleteEnemy(command: PlayerCommand) {
        const { id } = command;

        const animSpriteSlot1 = this.players[id].animSlot1.getAnimSprite();
        const animSpriteSlot2 = this.players[id].animSlot2.getAnimSprite();
        const animSpriteSlot3 = this.players[id].animSlot3.getAnimSprite();

        // death animation
        this.players[id].entity.getAnimSprite().forceAnimate(this.res["wolf-sheet"]["animations"][4]);
        animSpriteSlot1.forceAnimate(this.res["overlay-sheet"]["animations"][0]);
        animSpriteSlot2.forceAnimate(this.res["overlay-sheet"]["animations"][1]);
        animSpriteSlot3.forceAnimate(this.res["overlay-sheet"]["animations"][2]);
        animSpriteSlot1.sprite.visible = true;
        animSpriteSlot2.sprite.visible = true;
        animSpriteSlot3.sprite.visible = true;

        setTimeout(() => {
            this.players[id].id.destroy();
            this.players[id].health.destroy();
            this.players[id].healthOutline.destroy();
            this.players[id].healthBackground.destroy();
            this.players[id].entity.destroy();
            this.players[id].animSlot1.destroy();
            this.players[id].animSlot2.destroy();
            this.players[id].animSlot3.destroy();
            delete this.players[id];
        }, 400);
    }

    onServerMsg(msg: ServerMsg) {
        let content;
        if (msg.content.msgType == msgTypes.enemy) {
            content = msg.content as PlayerCommand;
        } else {
            return false;
        }

        const { x, y } = wordToView(new Vec2(content.pos.x, content.pos.y))
        content.pos.x = x;
        content.pos.y = y;

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
