// Import layer
import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, IBitmapTextStyle, Container } from "pixi.js";

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

import { PlayerActions } from "./PlayerActions";
import { ParticipantDetailsModel } from "../../Core/PlayerModel";
import { sleep } from "../../Utils/Sleep";


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

    public static MAX_HEALTH:number = 180;

    // Entities storage
    private players: Record<string, Player> = {};

    // Listener id
    private listener: Listener;

    // Application Related
    protected app: Application;
    protected res: Record<string, any>;

    // Web clients
    protected wsClient: WSClient;

    // Playher container
    private container: Container;

    // Lobby level context
    private levelContext: LobbyLevelContext;
    private detailsModel:ParticipantDetailsModel;

    static lastGamePlayerNames: Record<string, string> = {};
    private whooping:boolean = false;
    private fixtures:Entity[] = [];

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
        resource: Record<string, any>,
        details:ParticipantDetailsModel,
    ) {
        super("PlayerController", ecs);

        this.app = app;
        this.res = resource;
        this.wsClient = wsClient;
        this.levelContext = levelContext;

        this.listener = this.wsClient.addListener("enemy", (msg) =>
            this.onServerMsg(msg)
        );
        this.detailsModel = details;
        this.container = new Container();
        this.addFixtures();
    }

    onAttach() {
        this.app.stage.addChild(this.container);
    }

    
    onUpdate(deltaTime: number) {
        Object.values(this.players).map((player) => {
            const transform = player.entity.getTransform();
            const animsprite = player.entity.getAnimSprite();
            this.transformEntity (transform.pos, animsprite.sprite);
        });

        this.fixtures.map(e => {
            const transform = e.getTransform();
            const sprite = e.getSprite();
            this.transformEntity (transform.pos, sprite.sprite);
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
    
        const { id, pos } = content;

        const prevPlayer = this.players[id];
        if (Object.values(this.detailsModel.participants).length == 0) return;

        const details = this.detailsModel.getDetailsForPlayer(id);
        if (!details) return;

        const spritesheet = details.spritesheet;
        const tier = this.detailsModel.getTierFromAttributes(details.attributes);
        const name = details.name;

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
        
        sprite.loadFromConfig(this.app, this.res["player-sheet"], spritesheet, false);
        
        // if(tier == "alpha" || tier == "sigma") {
            // glow effect
        animSpriteBg.forceAnimate("glow-sigma");
        animSpriteBg.animSprite.loop = true;
        animSpriteBg.sprite.visible = false;
        animSpriteBg.animSprite.alpha = 0.9;
        animSpriteBg.sprite.position.set(0, -16);
        // }
        animSpriteBg.addStage(sprite.sprite, 0);

        sprite.addStage(this.container);
        animSpriteOverlay1.addStage(sprite.sprite);
        
        
        // Add healthBar
        const r1 = healthOutline.addColoredRectangle(24, 6, 0x000000);
        const r2 = healthBackground.addColoredRectangle(22, 4, 0x373232);
        const r3 = health.addColoredRectangle(22,4,0xF32D2D);
        // health.addColoredRectangle(22,4, tier == "alpha" ? 0xDDE9F3 : tier == "sigma" ? 0xB4F32D : 0xF32D2D);
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
        
        //place this layer above entity's ID number
        animSpriteOverlay2.addStage(sprite.sprite);

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
        
        const { id, pos, action, health } = command;
        
        if (Object.values(this.detailsModel.participants).length == 0) return;
        
        pos.x = Math.floor(pos.x);
        pos.y = Math.floor(pos.y);

        if (!this.players[id]) {
            this.createEnemy(command);
        }

        const entity = this.players[id].entity;
        const splitId = id.split('/')[1];
        const details = this.detailsModel.getDetailsForPlayer(id);
        if (!details) return;
        

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

        const lifeRecSize = Math.floor((health / PlayerLayer.MAX_HEALTH) * 22);
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

        const animSpriteOverlay2 = this.players[id].animLayerOverlay2.getAnimSprite();
                
        // death animation
        this.players[id].entity.getAnimSprite().forceAnimate(this.res["player-sheet"]["animations"][4]);

        animSpriteOverlay2.forceAnimate(this.res["overlay-sheet"]["animations"][0], 0.3);
        animSpriteOverlay2.sprite.visible = true;

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
        }, 800);
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

    async showWinner () {
        if (!this.whooping) {
            this.whooping = true;
            await sleep(400);
            Object.values(this.players).map(async (player) => {
                const transform = player.entity.getTransform();
                if (transform) {
                    player.animLayerBg.getAnimSprite().sprite.visible = true;
                    await sleep(400);
                    player.entity.getAnimSprite().forceAnimate(this.res["player-sheet"]["animations"][3]);
                }
            }
        );
        }
    }

    addFixtures () {
        const fix = [
                    {tex: "mapObstacle1", pos: [
                        new Vec2(1375, 687), 
                        new Vec2(1535, 687),
                        new Vec2(1695, 687),
                        new Vec2(543, 1293),
                        new Vec2(351, 1293),
                        new Vec2( 159, 1293)]}, 
            
                    {tex: "mapObstacle2", pos: [
                                            new Vec2(543, 685), 
                                            new Vec2(351, 685),
                                            new Vec2(159, 685),
                                            new Vec2(1375, 817),
                                            new Vec2(1535, 817),
                                            new Vec2(1695, 817)]},    
                    ]
        fix.map( f => {
            f.pos.map ( p => {
                const entity = this.ecs.createEntity( p.x, p.y, false);
                const sprite = entity.addSprite(this.app.loader.resources[f.tex]);
                sprite.sprite.anchor.y = 1.0;
                sprite.addStage(this.container);
                this.fixtures.push(entity);
            });
        });
    }
    
    transformEntity (pos:Vec2, container:Container) {
        // Calculates offsets to fix view
        const centerFactorX = (pos.x - CONTAINER_DIM_X / 2.0) / (CONTAINER_DIM_X / 2.0);
        const centerFactorY = (pos.y - CONTAINER_DIM_Y / 2.0) / (CONTAINER_DIM_Y / 2.0);
        const fixFactorX = (CONTAINER_DIM_X - CONTAINER_DIM_X * (1 - this.levelContext.zoom)) / 2.0;
        const fixFactorY = (CONTAINER_DIM_Y - CONTAINER_DIM_Y * (1 - this.levelContext.zoom)) / 2.0;

        // Fix the position for the player
        container.x = Math.floor(pos.x + this.levelContext.offsetX - fixFactorX * centerFactorX);
        container.y = Math.floor(pos.y + this.levelContext.offsetY - fixFactorY * centerFactorY);
    
        container.scale.x = (1.0 - this.levelContext.zoom);
        container.scale.y = (1.0 - this.levelContext.zoom);  
    }

    
}

export { PlayerLayer, Player };

