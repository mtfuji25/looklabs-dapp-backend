// Import layer
import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, IBitmapTextStyle, ITextStyle } from "pixi.js";

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
    idNumber: Entity;
    animLayer1: Entity;
    animLayer2: Entity;
    animLayer3: Entity;
}

class PlayerLayer extends Layer {

    public static MAX_ATTACK:number = 20;
    public static MAX_SPEED:number = 0.05;
    public static MAX_DEFENSE:number = 5;
    
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


    private readonly idStyle: Partial<IBitmapTextStyle> = {
        fontName: "8BITWONDERNominal",
        fontSize: 10,
        align: "center",
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
            const animSpriteBackground = player.animLayer1.getAnimSprite();
            const animSpriteMiddleground = player.animLayer2.getAnimSprite();
            const animSpriteForeground = player.animLayer3.getAnimSprite();

            animSpriteForeground.sprite.x = animSpriteMiddleground.sprite.x = animSpriteBackground.sprite.x = Math.floor(transform.pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
            animSpriteForeground.sprite.y = animSpriteMiddleground.sprite.y = animSpriteBackground.sprite.y = Math.floor(transform.pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY);

            animSpriteForeground.sprite.scale.x = animSpriteMiddleground.sprite.scale.x = animSpriteBackground.sprite.scale.x = (1.0 - this.levelContext.zoom);
            animSpriteForeground.sprite.scale.y = animSpriteMiddleground.sprite.scale.y = animSpriteBackground.sprite.scale.y = (1.0 - this.levelContext.zoom);
         
        });

        // sort sprite containers on the y axis
        this.container.children.sort((a,b) => {
            if (a.position.y > b.position.y) return 1;
            if (a.position.y < b.position.y) return -1;
            if (a.position.x > b.position.x) return 1;
            if (a.position.x < b.position.x) return -1;
            return 0;
          }); 
    }

    onDetach() {
        this.listener.destroy();
        this.container.removeChildren();
        this.app.stage.removeChild(this.container);
    }

    createEnemy(content: PlayerCommand) {
    
        const { id, pos, char_class, name, attack } = content;

        const prevPlayer = this.players[id];

        if (prevPlayer) {
            delete this.players[id];
        }

        const splitId = id.split('/')[1];


        // Creates and stores entity
        const idNumber = this.ecs.createEntity(pos.x - (splitId.length - 1) * 0.2, pos.y - 60, false);  
        const entity = this.ecs.createEntity(pos.x, pos.y, false);
        const health = this.ecs.createEntity(0, 0, false);
        const healthOutline = this.ecs.createEntity(0, 0, false);
        const healthBackground = this.ecs.createEntity(0, 0, false);

        // Animations slots
        const animLayer1 = this.ecs.createEntity(pos.x, pos.y - 64, false);
        const animLayer2 = this.ecs.createEntity(pos.x, pos.y - 64, false);
        const animLayer3 = this.ecs.createEntity(pos.x, pos.y - 16, false);

        const animSpriteBackground = animLayer1.addAnimSprite();
        const animSpriteMiddleground = animLayer2.addAnimSprite();
        const animSpriteForeground = animLayer3.addAnimSprite();

        animSpriteBackground.loadFromConfig(this.app, this.res["overlay-sheet"], null, true);
        
        animSpriteBackground.sprite.visible = false;
        animSpriteMiddleground.sprite.visible = false;
        animSpriteForeground.sprite.visible = false;

        // Add animsprite component
        const sprite = entity.addAnimSprite();

        // console.log("ID: ", id, " Nome: ", name);
        PlayerLayer.lastGamePlayerNames[id] = name;

        switch (char_class) {
            
            case "Avians":
            case "Avian":    
                sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_chicken`, false);
                break;
            case "Hounds":
            case "Hound":
                sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_hound`, false); 
                break;
            case "Insectoids":
            case "Insectoid":
                sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_beetle`, false);
                break;
            case 'Serpents':
            case 'Serpent':
                sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_snake`, false);
                break;
            default:
                sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_beetle`, false);
                break;
        }

        sprite.addStage(this.container);

        animSpriteBackground.addStage(this.container);
        animSpriteMiddleground.addStage(this.container);
        animSpriteForeground.addStage(this.container);
        
        // Add healthBar
        const r1 = healthOutline.addColoredRectangle(24, 6, 0x000000);
        const r2 = healthBackground.addColoredRectangle(22, 4, 0x373232);
        const r3 = health.addColoredRectangle(22,4, 0xF32D2D);
        r1.addStage(sprite.sprite);
        r2.addStage(sprite.sprite);
        r3.addStage(sprite.sprite);
        r1.sprite.x = -12;
        r1.sprite.y = -32;
        r2.sprite.x = -12;
        r2.sprite.y = -32;
        r3.sprite.x = -12;
        r3.sprite.y = -32;
    
        // Add id text
        const titleText = idNumber.addBMPText(splitId, this.idStyle);      
        titleText.text.anchor.set(0.5);
        titleText.addStage(sprite.sprite);
        titleText.text.x = 0;
        titleText.text.y = -20;
        

        this.players[id] = {
            entity: entity,
            idNumber: idNumber,
            healthOutline: healthOutline,
            healthBackground: healthBackground,
            health: health,
            animLayer1: animLayer1,
            animLayer2: animLayer2,
            animLayer3: animLayer3
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

        const textTransform = this.players[id].idNumber.getTransform();
        const healthBar = this.players[id].health;
        const entitySprite = entity.getAnimSprite();
        const entityTransform = entity.getTransform();

        const animLayer1 = this.players[id].animLayer1.getAnimSprite();
        const animLayer2 = this.players[id].animLayer2.getAnimSprite();
        const animLayer3 = this.players[id].animLayer3.getAnimSprite();

        const lifeRecSize = Math.floor((health / maxHealth) * 22);
        const lifeRectangle = healthBar.getColoredRectangle();
        lifeRectangle.setSize(lifeRecSize, 4);

        // Set all positions
        entityTransform.pos.x = Math.floor(pos.x);
        entityTransform.pos.y = Math.floor(pos.y);
        
        textTransform.pos.x = Math.floor(pos.x - (splitId.length - 1) * 0.2);
        textTransform.pos.y = Math.floor(pos.y - 20);
        
        // if else generator
        if (health <= 0) {
            if (action == 0 || action == 4) {
                entitySprite.animate(this.res["player-sheet"]["animations"][4]);
            }
            if (action == 1 || action == 5) {
                entitySprite.animate(this.res["player-sheet"]["animations"][5]);
            }
        } else {
            //
            // First set
            //
            if (action == 4) {
                entitySprite.animate(this.res["player-sheet"]["animations"][0]);

                animLayer1.sprite.visible = false;
                animLayer3.sprite.visible = false;
                animLayer3.sprite.visible = false;
            }
            // critical R
            if (action == 14) {
                entitySprite.animate(this.res["player-sheet"]["animations"][0]);
                animLayer1.forceAnimate(this.res["overlay-sheet"]["animations"][1]);
                animLayer1.sprite.visible = true;
            }
            // healing
            if (action == 24) {
                entitySprite.animate(this.res["player-sheet"]["animations"][0]);
                animLayer1.animate(this.res["overlay-sheet"]["animations"][3]);
                animLayer1.sprite.visible = true;
            }

            //
            // Second set
            //
            if (action == 5) {
                entitySprite.animate(this.res["player-sheet"]["animations"][1]);

                animLayer1.sprite.visible = false;
                animLayer2.sprite.visible = false;
                animLayer3.sprite.visible = false;
            }
            // critical L
            if (action == 15) {
                entitySprite.animate(this.res["player-sheet"]["animations"][1]);
                animLayer1.forceAnimate(this.res["overlay-sheet"]["animations"][2]);
                animLayer1.sprite.visible = true;

            }
            // healing
            if (action == 25) {
                entitySprite.animate(this.res["player-sheet"]["animations"][1]);
                animLayer1.animate(this.res["overlay-sheet"]["animations"][3]);
                animLayer1.sprite.visible = true;
            }

            //
            // Third set
            //
            if (action == 0) {
                entitySprite.forceAnimate(this.res["player-sheet"]["animations"][2]);

                animLayer1.sprite.visible = false;
                animLayer2.sprite.visible = false;
                animLayer3.sprite.visible = false;
            }
            // critical R
            if (action == 10) {
                entitySprite.animate(this.res["player-sheet"]["animations"][2]);
                animLayer1.forceAnimate(this.res["overlay-sheet"]["animations"][1]);
                animLayer1.sprite.visible = true;
            }
            // Healing
            if (action == 20) {
                entitySprite.animate(this.res["player-sheet"]["animations"][2]);
                animLayer1.animate(this.res["overlay-sheet"]["animations"][3]);
                animLayer1.sprite.visible = true;                
            }

            // Fourth set
            if (action == 1) {
                entitySprite.forceAnimate(this.res["player-sheet"]["animations"][3]);

                animLayer1.sprite.visible = false;
                animLayer2.sprite.visible = false;
                animLayer3.sprite.visible = false;
            }
            // critical L
            if (action == 11) {
                entitySprite.animate(this.res["player-sheet"]["animations"][3]);
                animLayer1.forceAnimate(this.res["overlay-sheet"]["animations"][2]);
                animLayer1.sprite.visible = true;
            }
            // Healing
            if (action == 21) {
                entitySprite.animate(this.res["player-sheet"]["animations"][3]);
                animLayer1.animate(this.res["overlay-sheet"]["animations"][3]);
                animLayer1.sprite.visible = true;
            }
            
            //
            // Fifth set
            //
            if (action == 2 || action == 3) {
                if (Math.random() < 0.5) {
                    entitySprite.forceAnimate(this.res["player-sheet"]["animations"][2]);
                } else {
                    entitySprite.forceAnimate(this.res["player-sheet"]["animations"][3]);
                }
                animLayer1.sprite.visible = false;
                animLayer2.sprite.visible = false;
                animLayer3.sprite.visible = false;
            }
            // Critical
            if (action == 12 || action == 13) {
                if (Math.random() < 0.5) {
                    // Right
                    entitySprite.forceAnimate(this.res["player-sheet"]["animations"][2]);
                    animLayer1.forceAnimate(this.res["overlay-sheet"]["animations"][1]);
                } else {
                    // Left
                    entitySprite.forceAnimate(this.res["player-sheet"]["animations"][3]);
                    animLayer1.forceAnimate(this.res["overlay-sheet"]["animations"][2]);
                }
                animLayer1.sprite.visible = true;
            }
            // Healing
            if (action == 22 || action == 23) {
                if (Math.random() < 0.5) {
                    entitySprite.forceAnimate(this.res["player-sheet"]["animations"][2]);
                } else {
                    entitySprite.forceAnimate(this.res["player-sheet"]["animations"][3]);
                }
                animLayer1.animate(this.res["overlay-sheet"]["animations"][3]);                
                animLayer1.sprite.visible = true;
            }

            //
            // Sixth set
            //
            if (action == 6 || action == 7) {
                if (Math.random() < 0.5) {
                    entitySprite.animate(this.res["player-sheet"]["animations"][0]);
                } else {
                    entitySprite.animate(this.res["player-sheet"]["animations"][1]);
                }
                animLayer1.sprite.visible = false;
                animLayer2.sprite.visible = false;
                animLayer3.sprite.visible = false;
            }
            // Critical
            if (action == 16 || action == 17) {
                if (Math.random() < 0.5) {
                    // Right
                    entitySprite.animate(this.res["player-sheet"]["animations"][0]);
                    animLayer1.forceAnimate(this.res["overlay-sheet"]["animations"][1]);
                    
                } else {
                    // Left
                    entitySprite.animate(this.res["player-sheet"]["animations"][1]);
                    animLayer1.forceAnimate(this.res["overlay-sheet"]["animations"][2]);                    
                }

                animLayer1.sprite.visible = true;
                
            }
            // Healing
            if (action == 26 || action == 27) {
                if (Math.random() < 0.5) {
                    entitySprite.animate(this.res["player-sheet"]["animations"][0]);
                } else {
                    entitySprite.animate(this.res["player-sheet"]["animations"][1]);
                }
                animLayer1.animate(this.res["overlay-sheet"]["animations"][3]);
                animLayer1.sprite.visible = true;
                
            }
        }
    }

    deleteEnemy(command:PlayerCommand) {
        const { id } = command;

        const animLayer1 = this.players[id].animLayer1.getAnimSprite();
                
        // death animation
        this.players[id].entity.getAnimSprite().forceAnimate(this.res["player-sheet"]["animations"][4]);

        animLayer1.forceAnimate(this.res["overlay-sheet"]["animations"][0]);
        animLayer1.sprite.visible = true;

        setTimeout(() => {
            this.players[id].idNumber.destroy();
            this.players[id].health.destroy();
            this.players[id].healthOutline.destroy();
            this.players[id].healthBackground.destroy();
            this.players[id].entity.destroy();
            this.players[id].animLayer1.destroy();
            this.players[id].animLayer2.destroy();
            this.players[id].animLayer3.destroy();
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
