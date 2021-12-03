import { Layer } from "../../Core/Layer";
import { ECS } from "../../Core/Ecs/Core/Ecs";

import { Application, ITextStyle } from "pixi.js";
import { Sprite } from "../../Core/Ecs/Components/Sprite";
import { Text } from "../../Core/Ecs/Components/Text";
import { RemainPlayersListener, RemainPlayersMsg, ServerMsg } from "../../Clients/Interfaces";
import { EngineContext } from "../../Core/Interfaces";

class BattleStatusLayer extends Layer {
    private app: Application;
    private title: Sprite;
    private card: Sprite;
    private timeLeft: Text;
    private playersLeft: Text;

        // context
    private context: EngineContext;

    private listener: RemainPlayersListener;

    private oneSecCount: number = 0.0;

    private readonly initialDate: number = Date.now();

    private readonly textStyle: Partial<ITextStyle> = {
        fontFamily: "monospace",
        fontWeight: "700",
        fontSize: "16px",
        lineHeight: 23.7,
        fill: "#000000",
        align: "center",
    }

    constructor(ecs: ECS, app: Application, context: EngineContext) {
        super("TesteLayer", ecs);

        this.app = app;
        this.context = context;

        this.listener = this.context.ws.addListener("remain-players", (msg) => this.onRemainPlayersMsg(msg));

        // Create two sprites
        this.title = this.ecs.createEntity(30, 30).addSprite();
        this.card = this.ecs.createEntity(30, 83).addSprite();

        // Creates both texts
        this.timeLeft = this.ecs.createEntity(62, 95).addText("00:00:00", this.textStyle);
        this.playersLeft = this.ecs.createEntity(158, 95).addText(null, this.textStyle);

        // Anchor it in 0,0
        this.title.sprite.anchor.set(0.0);
        this.card.sprite.anchor.set(0.0);

        // Set sprite image
        this.title.setImg(this.app.loader.resources["thePitSmall"]);
        this.card.setImg(this.app.loader.resources["infoCard"]);
    }

    onAttach() {
        // Add it to stage
        this.title.addStage(this.app);
        this.card.addStage(this.app);
        this.timeLeft.addStage(this.app);
        this.playersLeft.addStage(this.app);
    }

    onUpdate(deltaTime: number) {
        if (this.oneSecCount >= 1) {
            const { hours, minutes, seconds } = this.calculateTime();
            this.timeLeft.setText(`${hours}:${minutes}:${seconds}`);
            this.oneSecCount -= - 1.0;
        }

        this.oneSecCount += deltaTime;
    }

    onDetach() {
        this.self.destroy();
        this.title.remStage();
        this.card.remStage();
        this.timeLeft.remStage();
        this.playersLeft.remStage();
    
    }

    calculateTime(): Record<string, number> {
        const minTwoDigits = (n: number) => {
            return (n < 10 ? "0" : "") + String(n);
        };

        const difference = Date.now() - this.initialDate;

        let timeLeft = {};

        if (difference > 0) {
            timeLeft = {
                hours: minTwoDigits(
                    Math.floor((difference / (1000 * 60 * 60 * 24)) * 24)
                ),
                minutes: minTwoDigits(
                    Math.floor((difference / 1000 / 60) % 60)
                ),
                seconds: minTwoDigits(Math.floor((difference / 1000) % 60))
            };
        }

        return timeLeft;
    }

    // Sets remaining player texts
    onRemainPlayersMsg(msg: ServerMsg) {
        const { totalPlayers, remainingPlayers } = msg.content as RemainPlayersMsg;

        this.playersLeft.setText(`${remainingPlayers}/${totalPlayers} ALIVE`);

        return false;
    }
}

export { BattleStatusLayer };