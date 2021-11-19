import { Layer } from "../../Core/Layer";

// Ecs and Components imports
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";
import { ScheduledGameParticipant } from "../../Clients/Strapi";
import { Sprite } from "../../Core/Ecs/Components/Sprite";

interface KillLog {
    killer: string;
    action: string;
    killed: string;
    text?: {
        killer: Text;
        action: Text;
        killed: Text;
    }
};

class ResultsLayer extends Layer {
    // Current app instance
    private app: Application;

    //  queue for storing the kills
    private logs: Array<KillLog> = [];
    private fiveSecCount = 0.0;

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
        fontWeight: "700",
    };

    constructor(ecs: ECS, app: Application) {
        super("TesteLayer", ecs);

        this.app = app;
    }

    onAttach() {
        this.logs = [
            {
                killer: "dog44",
                action: "eviscerated",
                killed: "snake20"
            },
            {
                killer: "dog44",
                action: "eviscerated",
                killed: "snake20"
            },
        ]

        // renders all the results
        this.renderRows();
    }

    onUpdate(deltaTime: number) {
        if (this.fiveSecCount >= 5) {
            this.addLog({
                killer: "Beetle999",
                action: "eviscerated",
                killed: "Beetle999"
            });    
            if(this.logs.length > 13) {
                this.remLog();
            }
            // after all operations, render updated logs
            this.renderRows();
            this.fiveSecCount -= 5.0;
        }

        this.fiveSecCount += deltaTime;
    }

    // adds log on top of queue
    addLog(log: KillLog) {
        this.logs.unshift(log)
    };

    // Removes last log
    remLog() {
        const log = this.logs.at(-1);
        // Unstage texts from log
        if(log.text) {
            Object.values(log.text).forEach((text) => {
                text.remStage();
            });
        }
        // removes log from log queue
        this.logs.pop();

        // if the queue is still bigger than 13
        if(this.logs.length > 13) {
            this.remLog();
        } else {
            // returns if there are no logs to remove
            return;
        }
    }

    // loops through logs and renders them
    renderRows() {
        this.logs.forEach((log, index) =>
            this.renderLog(log, index)
        );
    }

    // create result for a specific participant
    renderLog(log: KillLog, index: number) {
        // represents how much the y coordinate is offset, according to current index
        const yOffset = 30 + index * 10;
        const initialX = 1400;
        let xOffset = 0;

        // Render the text for participants killed
        const killed = this.ecs
            .createEntity()
            .addText(`${log.killed}`, this.boldStyle)
    
        xOffset += killed.text.width;
        killed.setPos(initialX - xOffset, yOffset); 
        
        // render the text for participant name
        const action = this.ecs
            .createEntity()
            .addText(`${log.action}`, this.normalStyle);
        
        xOffset += action.text.width + 10;
        action.setPos(initialX - xOffset, yOffset);

        // Render the text for the position
        const killer = this.ecs
            .createEntity()
            .addText(`${log.killer}`, this.boldStyle);

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
    
    onDetach() {
        this.self.destroy();
    }
}

export { ResultsLayer };
