import { AnimatedSprite, Application, BaseTexture, BitmapText, Container, IBitmapTextStyle, Rectangle, Texture, Sprite as PixiSprite } from "pixi.js";
import { GameStateTypes } from "../../Clients/Interfaces";
import { AnimConfig } from "../../Core/Ecs/Components/AnimSprite";
import { Random, Vec2 } from "../../Utils/Math";
import { LogsLayer } from "./Log";
import { OverlayMap } from "./Overlays";
import { Player, PlayerLayer } from "./Player";
import { ViewLayer } from "./View";

class IntroSequence {

    private app:Application;
    private state:GameStateTypes;
    private playerLayer:PlayerLayer;
    private overlay:OverlayMap;
    private viewLayer:ViewLayer;
    private entities:IntroEntity[];
    private entityContainer:Container;
    private overlayContainer:Container;
    private res: Record<string, any>;
    private timer:number = 0;
    private fightText:BitmapText;

    private readonly fightStyle: Partial<IBitmapTextStyle> = {
        fontName: "DealersSolid",
        align: "center",
        fontSize: 400,
    };

    constructor (app: Application, playerLayer:PlayerLayer, overlay:OverlayMap, viewLayer:ViewLayer, resource: Record<string, any>) {
        this.app = app;
        this.playerLayer = playerLayer;
        this.overlay = overlay;
        this.viewLayer = viewLayer;
        this.entities = [];
        this.res = resource;
        this.entityContainer = new Container();
        this.overlayContainer = new Container();
        this.fightText = new BitmapText("", this.fightStyle);
        
        this.playerLayer.getPlayers().forEach (player => {
            this.entities.push( 
                new IntroEntity( app, player, this.res, this.entityContainer, this.overlayContainer)
            );
        });

        this.entities = Random.shuffle(this.entities);

        this.playerLayer.getContainer().addChild(this.entityContainer);
        this.overlay.getContainer().addChild(this.overlayContainer);
        

    }

    updateIntroState (state:GameStateTypes) {
        
        switch (state) {
            case "spawn":
                this.playerLayer.getPlayers().forEach (player => {
                    player.entity.getAnimSprite().sprite.alpha = 0.0;
                    player.entity.getAnimSprite().sprite.visible = true;
                }); 
                break;                
            case "countdown3":
                this.showText("3");
                this.showAllEntities();
                break;
            case "countdown2":
                this.showText("2");
                this.showAllEntities();
                break;                
            case "countdown1":
                this.showText("1");
                this.showAllEntities();
                break;
            case "countdown0":
                this.showText("fight!");
                this.showAllEntities();
                break;                
            case "fight":
                //reset everyting
                this.showAllEntities();
                this.reset();              
                this.destroy();
                this.viewLayer.interactive = true;
                break;  
        }
        this.state = state;
    }

    showAllEntities () {
        this.playerLayer.getPlayers().forEach (player => {
            player.entity.getAnimSprite().sprite.alpha = 1.0;
            player.entity.getAnimSprite().sprite.visible = true;
        }); 
    }

    showText (txt:string) {
        if (this.fightText && !this.fightText.parent)
            this.overlayContainer.addChild(this.fightText);
    
        this.fightText.text = txt;
        this.alignText();
        
    }

    alignText () {
        if (this.fightText) {
            this.fightText.x = (this.overlay.getContainer().width - this.fightText.width) * 0.5;
            this.fightText.y = (this.overlay.getContainer().height - this.fightText.height) * 0.5;
        }
        
    }

    reset () {
        this.playerLayer.getPlayers().forEach (player => {
            player.entity.getAnimSprite().animSprite.scale.x = 1.0;
            player.entity.getAnimSprite().sprite.alpha = 1.0;
            player.health.getColoredRectangle().graphics.visible = true;
            player.healthBackground.getColoredRectangle().graphics.visible = true;
            player.healthOutline.getColoredRectangle().graphics.visible = true;
            player.idNumber.getBMPText().text.visible = true;   
            
        }); 
        
        
    }

    spawn (delta:number) {
        // we have 5 seconds to show all players
        const totalTime = 5.0;
        if (this.timer < totalTime) {
            console.log("TICK");
            const totalIterations = totalTime/delta;
            const iterations = this.timer/delta;
            const numToSpawn = Math.floor((this.entities.length / totalIterations) * iterations);
            let alreadyShown = 0;
            let i = 0;
            console.log(alreadyShown, numToSpawn);
            while (alreadyShown < numToSpawn) {
                const entity  = this.entities[i];
                if (!entity.visible) {
                    console.log("SHOW");
                    entity.show();
                }
                i++;
                alreadyShown++;
            }
        } else {
            this.entities.forEach( e => e.show());
        }
        
    }

    onUpdate (deltaTime:number) {
        this.timer += deltaTime;
        if (this.state == "spawn") {
            this.spawn(deltaTime);
        }
        if (this.entities) {
            this.entities.forEach( e => e.onUpdate());
        }
        this.alignText();
    }

    destroy () {
        
        this.entityContainer.removeChildren();
        this.overlayContainer.removeChildren();

        this.playerLayer.getContainer().removeChild(this.entityContainer);
        this.overlay.getContainer().removeChild(this.overlayContainer);
        delete this.entities;
        delete this.fightText;
    }
}


class IntroEntity {

    public visible:boolean = false;
    private player:Player;
    private playerContainer:Container;
    private playerPosition:Vec2;
    private flameAnimation:AnimatedSprite;
    private entityContainer:Container;
    private overlayContainer:Container;
    private bubble:PixiSprite;
    private app:Application;
    private res: Record<string, any>;
    private showing:boolean = true;

    constructor (app: Application, player:Player, resources: Record<string, any>, entityContainer:Container, overlayContainer:Container) {
        this.app = app;
        this.res = resources;
        this.player = player;
        const sprite = this.player.entity.getAnimSprite().sprite;
        this.player.entity.getAnimSprite().animSprite.scale.x = Math.random() > 0.5 ? 1 : -1;

        this.playerPosition = new Vec2(sprite.x, sprite.y - 16);
        this.playerContainer = this.player.entity.getAnimSprite().sprite;
        this.entityContainer = entityContainer;
        this.overlayContainer = overlayContainer;
        this.createFlames ();
    }

    createFlames () {
        const config:AnimConfig = this.res["flames-sheet"];
        const flameTextures: Texture[] = [];
        const url: string = this.app.loader.resources[config["resource"]].url;
        const ssheet = BaseTexture.from(url);
        const animation = config["flames"];
        animation.forEach((frame) => {
            flameTextures.push(
                new Texture(ssheet, new Rectangle(
                    frame.x, frame.y, frame.width, frame.height
                ))
            );
        });
        
        this.flameAnimation = new AnimatedSprite(flameTextures);
        this.flameAnimation.animationSpeed = config["speed"];
        this.flameAnimation.loop = false;
        this.flameAnimation.anchor.set(config["anchor"]);        
        this.flameAnimation.x = this.playerPosition.x;
        this.flameAnimation.y = this.playerPosition.y;
        this.flameAnimation.onFrameChange = () => {
            console.log("ON FRAME CHANGE");
            this.showSprite(this.flameAnimation.currentFrame);
        }
        this.flameAnimation.onComplete = () => {
            this.flameAnimation.visible = false;
            this.playerContainer.alpha = 1.0;
            if (this.bubble) {
                const pos = this.overlayContainer.toLocal(this.flameAnimation.position);
                this.bubble.x = pos.x ;
                this.bubble.y = pos.y + 8;
                this.overlayContainer.addChild(this.bubble);
                this.hideShowHealth(false);
                setTimeout( () => { 
                    this.overlayContainer.removeChild(this.bubble); 
                    this.hideShowHealth(true);
                }, Math.random() * 1000 + 1000);
            }
            // start to fade out elements
            setTimeout( () => { 
                this.showing = false;
            }, 1000);
        }
    }

    hideShowHealth (visible:boolean) {
        this.player.health.getColoredRectangle().graphics.visible = visible;
        this.player.healthBackground.getColoredRectangle().graphics.visible = visible;
        this.player.healthOutline.getColoredRectangle().graphics.visible = visible;
        this.player.idNumber.getBMPText().text.visible = visible;

    }

    createBubble () {
        const config:AnimConfig =  this.res["bubbles-sheet"];
        const url: string = this.app.loader.resources[config["resource"]].url;
        const ssheet = BaseTexture.from(url);
        const bubble = config["bubbles"];
        
        const textureFrame = bubble[Math.floor(Math.random() * bubble.length)];
        this.bubble = new PixiSprite(
            new Texture(ssheet, new Rectangle(
                textureFrame.x, textureFrame.y, textureFrame.width, textureFrame.height
            ))
        );
        this.bubble.anchor.x = 0.5;
        this.bubble.anchor.y = 1.0;
        this.bubble.alpha = 0.0;
    }

    show () {
        if (!this.visible) {
            this.visible = true;
            this.entityContainer.addChild(this.flameAnimation);
            this.flameAnimation.play();
            if (Math.random() > 0.6) this.createBubble();
        }
    }

    onUpdate () {
        if (this.bubble) {
            if (this.showing) {
                this.bubble.alpha += 0.2;
            } else {
                this.bubble.alpha -= 0.2;
            }    
            const pos = this.overlayContainer.toLocal(this.flameAnimation.position);
            this.bubble.x = pos.x ;
            this.bubble.y = pos.y + 8;
        }
    }

    showSprite (frame:number) {
        console.log("ON FRAME CHANGE", frame);
        if (frame >= 3) {
            if (frame == 3) {
                this.playerContainer.alpha = 0.5;    
            } else if (frame == 4) {
                this.playerContainer.alpha = 0.75;
            } else if (frame == 5) {
                this.playerContainer.alpha = 1.0;
            }
            this.playerContainer.visible = true;
        }
    }

}


export { IntroSequence }