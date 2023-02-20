import { Layer } from "../../Core/Layer";

// Ecs and Components imports
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { BMPText } from "../../Core/Ecs/Components/BMPText";

// Pixi imports
import { Application, Container, IBitmapTextStyle } from "pixi.js";
import { KillMsg, Listener, ServerMsg } from "../../Clients/Interfaces";
import { EngineContext } from "../../Core/Interfaces";


interface KillLog {
    killer: string;
    action: string;
    killed: string;
    text?: {
        killer: BMPText;
        action: BMPText;
        killed: BMPText;
    };
}

class LogsLayer extends Layer {

    static MAX_LOG:number = 7;

    // Current app instance
    private app: Application;

    // context
    private context: EngineContext;

    //  queue for storing the kills
    private logs: Array<KillLog> = [];

    private listener: Listener;

    private percentX: number;

    private container:Container;

    private readonly normalStyle: Partial<IBitmapTextStyle> = {
        fontName: "Rubik-Regular",
        align: "left",
        fontSize: 18,
    };

    private readonly boldStyle: Partial<IBitmapTextStyle> = {
        fontName: "Rubik-Bold",
        align: "left",
        fontSize: 18
    };
    private screenX: number;

    constructor(ecs: ECS, app: Application, context: EngineContext) {
        super("TesteLayer", ecs);

        this.app = app;
        this.context = context;

        this.percentX = this.app.view.clientWidth / 100;
        this.screenX = this.app.view.clientWidth;
        this.container = new Container();

        this.listener = this.context.ws.addListener("kill", msg => this.onKill(msg));
    }

    onAttach() {
        this.app.stage.addChild(this.container);
    }

    onUpdate(deltaTime: number) {
        if(this.app.view.clientWidth != this.screenX ) {
            this.screenX = this.app.view.clientWidth;
            this.percentX = this.screenX / 100;
            this.logs.forEach((log, index) => this.renderLog(log, index));
        }
    }

    // adds log on top of queue
    addLog(log: KillLog) {
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
    renderLog(log: KillLog, index: number) {
        // represents how much the y coordinate is offset, according to current index
        const yOffset = 30 + index * 30;
        const initialX = 100 * this.percentX;
        let xOffset = 40;

        // if text already exists, just reposition it
        if (log.text) {
            const { killed, action, killer } = log.text;

            // set killed pos
            xOffset += killed.text.width;
            killed.setPos(initialX - xOffset, yOffset);

            // set action pos
            xOffset += action.text.width + 10;
            action.setPos(initialX - xOffset, yOffset);

            // set killer pos
            xOffset += killer.text.width + 10;
            killer.setPos(initialX - xOffset, yOffset);

            if (index == LogsLayer.MAX_LOG - 1) {
                killer.text.alpha = 0.6;
                action.text.alpha = 0.6;
                killed.text.alpha = 0.6;
            }
        } else {
            // Render the text for participants killed
            const killed = this.ecs.createEntity().addBMPText(`${log.killed}`, this.boldStyle);

            xOffset += killed.text.width;
            killed.setPos(initialX - xOffset, yOffset);

            // render the text for participant name
            const action = this.ecs.createEntity().addBMPText(`${log.action}`, this.normalStyle);

            xOffset += action.text.width + 10;
            action.setPos(initialX - xOffset, yOffset);

            // Render the text for the position
            const killer = this.ecs.createEntity().addBMPText(`${log.killer}`, this.boldStyle);

            xOffset += killer.text.width + 10;
            killer.setPos(initialX - xOffset, yOffset);

            // stage all texts
            killed.addStage(this.container);
            action.addStage(this.container);
            killer.addStage(this.container);

            log.text = {
                killed: killed,
                action: action,
                killer: killer
            };
        }
    }

    onDetach() {
        this.listener.destroy();

        this.logs.map((log) => {
            if (log.text) {
                Object.values(log.text).forEach((text) => {
                    text.remStage();
                });
            }
        });
        this.container.removeChildren();
        this.app.stage.removeChild(this.container);
    }

    // server msg when kill happens
    onKill(msg: ServerMsg) {
        const { killer, action, killed } = msg.content as KillMsg;
            
        this.addLog({
            killer: killer,
            action: action,
            killed: killed
        });

        if (this.logs.length > LogsLayer.MAX_LOG) {
            this.remLog();
        }
        // after all operations, render updated logs
        this.logs.forEach((log, index) => this.renderLog(log, index));

        return true;
    }

    getContainer():Container { return this.container; }
}

export { LogsLayer };
