import { Layer } from "../../Core/Layer";

// Ecs and Components imports
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";
import { KillListener, KillMsg, ServerMsg } from "../../Clients/Interfaces";
import { EngineContext } from "../../Core/Interfaces";

interface KillLog {
    killer: string;
    action: string;
    killed: string;
    text?: {
        killer: Text;
        action: Text;
        killed: Text;
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

    private readonly normalStyle: Partial<ITextStyle> = {
        fontFamily: "monospace",
        fontStyle: "normal",
        fontWeight: "400",
        fontSize: 15,
        fill: 0xffffff,
        lineHeight: 21,
    };

    private readonly boldStyle: Partial<ITextStyle> = {
        ...this.normalStyle,
        fontWeight: "700"
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
        const log = this.logs.at(-1);
        // Unstage texts from log
        if (log.text) {
            Object.values(log.text).forEach((text) => {
                text.remStage();
            });
        }
        // removes log from log queue
        this.logs.pop();

        // if the queue is still bigger than 13
        if (this.logs.length > 13) {
            this.remLog();
        } else {
            // returns if there are no logs to remove
            return;
        }
    }

    // loops through logs and renders them
    renderRows() {
        this.logs.forEach((log, index) => this.renderLog(log, index));
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
            index > 12 ? killed.text.alpha = 0.5 : null;

            // set action pos
            xOffset += action.text.width + 10;
            action.setPos(initialX - xOffset, yOffset);
            index > 12 ? action.text.alpha = 0.5 : null;

            // set killer pos
            xOffset += killer.text.width + 10;
            killer.setPos(initialX - xOffset, yOffset);
            index > 12 ? killed.text.alpha = 0.5 : null;

        } else {
            // Render the text for participants killed
            const killed = this.ecs.createEntity().addText(`${log.killed}`, this.boldStyle);

            xOffset += killed.text.width;
            killed.setPos(initialX - xOffset, yOffset);

            // render the text for participant name
            const action = this.ecs.createEntity().addText(`${log.action}`, this.normalStyle);

            xOffset += action.text.width + 10;
            action.setPos(initialX - xOffset, yOffset);

            // Render the text for the position
            const killer = this.ecs.createEntity().addText(`${log.killer}`, this.boldStyle);

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
        this.self.destroy();
    }

    // server msg when kill happens
    onKill(msg: ServerMsg) {
        const { killer, action, killed } = msg.content as KillMsg;
            
        this.addLog({
            killer: killer,
            action: action,
            killed: killed
        });

        if (this.logs.length > 13) {
            this.remLog();
        }
        // after all operations, render updated logs
        this.renderRows();

        return true;
    }
}

export { LogsLayer };
