import { Layer } from "../../Core/Layer";

// Ecs and Components imports
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { BMPText } from "../../Core/Ecs/Components/BMPText";

// Pixi imports
import { Application, IBitmapTextStyle } from "pixi.js";
import { KillListener, KillMsg, ServerMsg } from "../../Clients/Interfaces";
import { EngineContext } from "../../Core/Interfaces";
import { sleep, syncSleep } from "../../Utils/Sleep";


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
    // Current app instance
    private app: Application;

    // context
    private context: EngineContext;

    //  queue for storing the kills
    private logs: Array<KillLog> = [];

    private listener: KillListener;

    private percentX: number;

    private readonly normalStyle: Partial<IBitmapTextStyle> = {
        fontName: "Rubik-Regular",
        align: "left",
        fontSize: 15,
    };

    private readonly boldStyle: Partial<IBitmapTextStyle> = {
        fontName: "Rubik-Bold",
        align: "left",
        fontSize: 15
    };

    constructor(ecs: ECS, app: Application, context: EngineContext) {
        super("TesteLayer", ecs);

        this.app = app;
        this.context = context;

        this.percentX = this.app.screen.width / 100;

        this.listener = this.context.ws.addListener("kill", msg => this.onKill(msg));
    }

    onAttach() {}

    onUpdate(deltaTime: number) {}

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
        const yOffset = 30 + index * 25;
        const initialX = 97.222 * this.percentX;
        let xOffset = 0;

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
            killed.addStage(this.app);
            action.addStage(this.app);
            killer.addStage(this.app);

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
        })
    }

    // server msg when kill happens
    onKill(msg: ServerMsg) {
        const { killer, action, killed } = msg.content as KillMsg;
            
        this.addLog({
            killer: killer,
            action: action,
            killed: killed
        });

        if (this.logs.length > 12) {
            this.remLog();
        }
        // after all operations, render updated logs
        this.logs.forEach((log, index) => this.renderLog(log, index));

        return true;
    }
}

export { LogsLayer };
