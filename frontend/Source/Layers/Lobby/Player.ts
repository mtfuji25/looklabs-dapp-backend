// Import layer
import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, IBitmapTextStyle } from "pixi.js";

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
import { PlayerActions } from "./PlayerActions";

interface Player {
    entity: Entity;
    health: Entity;
    healthOutline: Entity;
    healthBackground: Entity;
    idNumber: Entity;
    animLayerBg: Entity;
    animLayerOverlay1: Entity;
    animLayerOverlay2: Entity;
}

class PlayerLayer extends Layer {

    // Entities storage
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

    private whooping:boolean = false;

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
    
        const { id, pos, char_class, name } = content;

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
        const animBg = this.ecs.createEntity(0,0, false);
        const animOverlay1 = this.ecs.createEntity(0,0, false);
        const animOverlay2 = this.ecs.createEntity(0,0, false);

        const animSpriteBg = animBg.addAnimSprite();
        const animSpriteOverlay1 = animOverlay1.addAnimSprite();
        const animSpriteOverlay2 = animOverlay2.addAnimSprite();

        animSpriteBg.loadFromConfig(this.app, this.res["overlay-sheet"], null, true);
        animSpriteOverlay1.loadFromConfig(this.app, this.res["overlay-sheet"], null, true);
        animSpriteOverlay2.loadFromConfig(this.app, this.res["overlay-sheet"], null, true);
        
        animSpriteBg.sprite.visible = false;
        animSpriteOverlay1.sprite.visible = false;
        animSpriteOverlay2.sprite.visible = false;

        // Add animsprite component
        const sprite = entity.addAnimSprite();
        // hide sprite so we can spawn them during intro
        sprite.sprite.visible = false;
        sprite.sprite.alpha = 0;
        PlayerLayer.lastGamePlayerNames[id] = name;
        
        /*
        TODO: When we're ready to load assets from NFT data, do it here 
        content.url
        */

        switch (char_class) {
            
            case "Avians":
            case "Avian":    
                if (content.tier == "delta" || content.tier == "beta") {
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], "delta_chicken", false);
                } else {    
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_chicken`, false);
                }
                break;
            case "Hounds":
            case "Hound":
                if (content.tier == "delta" || content.tier == "beta") {
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], "delta_hound", false);
                } else {    
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_hound`, false);
                }
                break;
            case "Insectoids":
            case "Insectoid":
                if (content.tier == "delta" || content.tier == "beta") {
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], "delta_beetle", false);
                } else {    
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_beetle`, false);
                }
                break;
            case 'Serpents':
            case 'Serpent':
                if (content.tier == "delta" || content.tier == "beta") {
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], "delta_snake", false);
                } else {    
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_snake`, false);
                }
                
                break;
            default:
                if (content.tier == "delta" || content.tier == "beta") {
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], "delta_beetle", false);
                } else {    
                    sprite.loadFromConfig(this.app, this.res["player-sheet"], `${content.tier}_beetle`, false);
                }
                break;
        }
        
        if(content.tier == "alpha" || content.tier == "sigma") {
            // glow effect
            animSpriteBg.forceAnimate(`glow-${content.tier}`);
            animSpriteBg.animSprite.loop = true;
            animSpriteBg.sprite.visible = true;
            animSpriteBg.animSprite.alpha = 0.9;
            animSpriteBg.sprite.position.set(0, -16);
        }

        animSpriteBg.addStage(sprite.sprite, 0);
        sprite.addStage(this.container);
        animSpriteOverlay1.addStage(sprite.sprite);
        animSpriteOverlay2.addStage(sprite.sprite);
        
        // Add healthBar
        const r1 = healthOutline.addColoredRectangle(24, 6, 0x000000);
        const r2 = healthBackground.addColoredRectangle(22, 4, 0x373232);
        const r3 = health.addColoredRectangle(22,4, content.tier == "alpha" ? 0xDDE9F3 : content.tier == "sigma" ? 0xB4F32D : 0xF32D2D);
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
            animLayerBg: animBg,
            animLayerOverlay1: animOverlay1,
            animLayerOverlay2: animOverlay2
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

        const animLayerBg = this.players[id].animLayerBg.getAnimSprite();
        const animLayerOverlay1 = this.players[id].animLayerOverlay1.getAnimSprite();
        const animLayerOverlay2 = this.players[id].animLayerOverlay2.getAnimSprite();

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
            // die right
            if (action == PlayerActions.ATTACK_RIGHT || action == PlayerActions.WALK_RIGHT) {
                entitySprite.animate(this.res["player-sheet"]["animations"][4]);
            }
            // die left
            if (action == PlayerActions.ATTACK_LEFT || action == PlayerActions.WALK_LEFT) {
                entitySprite.animate(this.res["player-sheet"]["animations"][5]);
            }
        } else {
            //
            // First set
            //
            if (action == PlayerActions.WALK_RIGHT) {
                entitySprite.animate(this.res["player-sheet"]["animations"][0]);
                animLayerOverlay1.sprite.visible = false;
            }
         
            // healing
            if (action == PlayerActions.WALK_RIGHT_HEALING) {
                entitySprite.animate(this.res["player-sheet"]["animations"][0]);
                animLayerOverlay1.animate(this.res["overlay-sheet"]["animations"][3]);
                animLayerOverlay1.sprite.visible = true;
            }

            //
            // Second set
            //
            if (action == PlayerActions.WALK_LEFT) {
                entitySprite.animate(this.res["player-sheet"]["animations"][1]);
                animLayerOverlay1.sprite.visible = false;
            }
           
            // healing
            if (action == PlayerActions.WALK_LEFT_HEALING) {
                entitySprite.animate(this.res["player-sheet"]["animations"][1]);
                animLayerOverlay1.animate(this.res["overlay-sheet"]["animations"][3]);
                animLayerOverlay1.sprite.visible = true;
            }
            //
            // Third set
            //
            if (action == PlayerActions.ATTACK_RIGHT) {
                entitySprite.forceAnimate(this.res["player-sheet"]["animations"][2]);
                animLayerOverlay1.sprite.visible = false;
            }
            // critical R
            if (action == PlayerActions.ATTACK_RIGHT_CRITICAL) {
                entitySprite.animate(this.res["player-sheet"]["animations"][2]);
                animLayerOverlay1.forceAnimate(this.res["overlay-sheet"]["animations"][1]);
                animLayerOverlay1.sprite.visible = true;
            }
        
            // Fourth set
            if (action == PlayerActions.ATTACK_LEFT) {
                entitySprite.forceAnimate(this.res["player-sheet"]["animations"][3]);
                animLayerOverlay1.sprite.visible = false;
            }
            // critical L
            if (action == PlayerActions.ATTACK_LEFT_CRITICAL) {
                entitySprite.animate(this.res["player-sheet"]["animations"][3]);
                animLayerOverlay1.forceAnimate(this.res["overlay-sheet"]["animations"][2]);
                animLayerOverlay1.sprite.visible = true;
            }
        }
    }

    deleteEnemy(command:PlayerCommand) {
        const { id } = command;

        const animLayerOverlay1 = this.players[id].animLayerOverlay1.getAnimSprite();
                
        // death animation
        this.players[id].entity.getAnimSprite().forceAnimate(this.res["player-sheet"]["animations"][4]);

        animLayerOverlay1.forceAnimate(this.res["overlay-sheet"]["animations"][0]);
        animLayerOverlay1.sprite.visible = true;

        setTimeout(() => {
            this.players[id].idNumber.destroy();
            this.players[id].health.destroy();
            this.players[id].healthOutline.destroy();
            this.players[id].healthBackground.destroy();
            this.players[id].entity.destroy();
            this.players[id].animLayerBg.destroy();
            this.players[id].animLayerOverlay1.destroy();
            this.players[id].animLayerOverlay2.destroy();
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

    getContainer ():Container {
        return this.container;
    }

    getPlayers ():Player[] {
        return Object.values(this.players);
    }

    
}

export { PlayerLayer, Player };

