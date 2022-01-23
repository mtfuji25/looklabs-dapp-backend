import { Layer } from "../../Core/Layer";

// Ecs and Components imports
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { BMPText } from "../../Core/Ecs/Components/BMPText";
import { ColoredRectangle } from "../../Core/Ecs/Components/ColoredRectangle";

// Pixi imports
import { Application, Container, IBitmapTextStyle } from "pixi.js";
import { EngineContext } from "../../Core/Interfaces";
import { ScheduledGame } from "../../Clients/Strapi";
import { Logger } from "../../Utils/Logger";


interface JoinLog {
    player: string;
    text?: {
        player: BMPText;
        action: BMPText;
    };
}

class LogsLayer extends Layer {

    static MAX_LOG:number = 12;
    static LOG_REFRESH_TIME:number = 3.0;
    // Current app instance
    private app: Application;

    // context
    private context: EngineContext;

    //  queue for storing the kills
    private logs: Array<JoinLog> = [];

    private screenX: number;

    // count that resets every 3 seconds
    private refreshCount: number = 0.0;

    // Current Update Promisse
    private updateRequest: ScheduledGame;

    private currentGame: ScheduledGame;
    private playersInBattle:Set<string> = new Set();
    private darkOverlay:ColoredRectangle;

    private readonly normalStyle: Partial<IBitmapTextStyle> = {
        fontName: "Rubik-Regular",
        align: "left",
        fontSize: 20,
    };

    private readonly boldStyle: Partial<IBitmapTextStyle> = {
        fontName: "Rubik-Bold",
        align: "left",
        fontSize: 20
    };

    private container:Container;

    constructor(ecs: ECS, app: Application, context: EngineContext,currentGame: ScheduledGame) {
        super("TesteLayer", ecs);
        this.app = app;
        this.context = context;
        this.currentGame = currentGame;
        this.screenX = this.app.view.clientWidth;
        this.container = new Container();
    }

    onAttach() {
        if (this.currentGame.scheduled_game_participants.length > 0) {

            this.currentGame.scheduled_game_participants.forEach( player => {
                if (!this.playersInBattle.has(player.nft_id)) {
                    this.playersInBattle.add(player.nft_id);
                    if (player.name && player.name !== "undefined") {
                         this.addPlayerToLog(player.name);
                    }
                }
            });         
        }

        this.darkOverlay = this.ecs.createEntity(0,0,false).addColoredRectangle(this.app.view.clientWidth, this.app.view.clientHeight, 0x000000);
        this.darkOverlay.graphics.alpha = 0.4;
        this.container.addChildAt(this.darkOverlay.graphics, 0);
        
        this.app.stage.addChild(this.container);
    }

    async onUpdate(deltaTime: number) {

        // on window resize 
        if(this.app.view.clientWidth != this.screenX ) {
            this.screenX = this.app.view.clientWidth;
            this.logs.forEach((log, index) => this.renderLog(log, index));
            this.darkOverlay.graphics.width = this.screenX;
            this.darkOverlay.graphics.height = this.app.screen.height;
        }
        
        if (this.refreshCount >= LogsLayer.LOG_REFRESH_TIME) {

            try {
                // Request the game using gameId passed in the constructor
                this.updateRequest = await this.context.strapi.getGameById(this.currentGame.id);
    
                this.updateRequest.scheduled_game_participants.map((player) => {
                    if (!this.playersInBattle.has(player.nft_id)) {
                        this.playersInBattle.add(player.nft_id);
                        if (player.name && player.name !== "undefined")
                            this.addPlayerToLog(player.name);
                    }
                });
    
                
            } catch(e) {
                console.log("Failed to request game in strapi");
                console.log(JSON.stringify(e, null, 4));
            }           

            this.refreshCount -= LogsLayer.LOG_REFRESH_TIME;
        }

        this.refreshCount += deltaTime;
    }

    // adds log on top of queue
    addLog(log: JoinLog) {
        this.logs.unshift(log);
    }

    // Removes last log
    remLog() {
        if (this.logs != undefined && this.logs.length) {
            const log = this.logs[this.logs.length-1]

            // after reducing opacity, unstage text
            if (log && log.text) {
                Object.values(log.text).forEach((text) => {
                    text.remStage();
                });
            }
            // removes log from log queue
            this.logs.pop();
        }
    }

    // create result for a specific participant
    renderLog(log: JoinLog, index: number) {
        // represents how much the y coordinate is offset, according to current index
        const yOffset = 30 + index * 35;
        const initialX = this.screenX ;
        let xOffset = 40;

        // if text already exists, just reposition it
        if (log.text) {
            const { player, action } = log.text;

            
            // set action pos
            xOffset += action.text.width;
            action.setPos(initialX - xOffset, yOffset);

            xOffset += player.text.width + 5;
            player.setPos(initialX - xOffset, yOffset);

            if (index == LogsLayer.MAX_LOG - 1) {
                action.text.alpha = 0.6;
                player.text.alpha = 0.6;
            }

            
        } else {
            // Render the text for participants killed
            const player = this.ecs.createEntity().addBMPText(`${log.player}`, this.boldStyle);

            
            // render the text for participant name
            const action = this.ecs.createEntity().addBMPText("entered battle", this.normalStyle);

            xOffset += action.text.width;
            action.setPos(initialX - xOffset, yOffset);

            xOffset += player.text.width + 5;
            player.setPos(initialX - xOffset, yOffset);

            // stage all texts
            // this.container.addChild(player.text);
            // this.container.addChild(action.text);
            action.addStage(this.container);
            player.addStage(this.container);

            log.text = {
                player: player,
                action: action
            };
        }
    }

    onDetach() {
        
        this.logs.map((log) => {
            if (log.text) {
                Object.values(log.text).forEach((text) => {
                    text.remStage();
                });
            }
        })
        this.container.removeChildren();
        this.app.stage.removeChild(this.container);
    }


    addPlayerToLog(playerName:string) {
            
        this.addLog({
            player: playerName
        });

        if (this.logs.length > LogsLayer.MAX_LOG) {
            this.remLog();
        }
        
        this.logs.forEach((log, index) => this.renderLog(log, index));

    }
}

export { LogsLayer };
