import { Layer } from "../../Core/Layer";
import { ECS } from "../../Core/Ecs/Core/Ecs";

import { Application, ITextStyle } from "pixi.js";
import { Sprite } from "../../Core/Ecs/Components/Sprite";
import { Panel } from "../../Core/Ecs/Components/Panel";
import { Text } from "../../Core/Ecs/Components/Text";
import { GameTimeListener, GameTimeMsg, RemainPlayersListener, RemainPlayersMsg, ServerMsg } from "../../Clients/Interfaces";
import { EngineContext } from "../../Core/Interfaces";

class BattleStatusLayer extends Layer {
    private app: Application;
    private title: Sprite;
    private card: Panel;
    private timeLeft: Text;
    private playersLeft: Text;

    // context
    private context: EngineContext;

    private listener: RemainPlayersListener;

    private gameTimeListener: GameTimeListener;

    private readonly textStyle: Partial<ITextStyle> = {
        fontFamily: "Space Mono",
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

        this.listener = this.context.ws.addListener("remain-players", msg => this.onRemainPlayersMsg(msg));

        // listens to clock updates from backend
        this.gameTimeListener = this.context.ws.addListener("game-time", msg => this.onGameTimeMsg(msg));

        // Create two sprites
        this.title = this.ecs.createEntity(30, 30).addSprite();
        this.card = this.ecs.createEntity(30, 83).addPanel(this.app.loader.resources["infoCard"]);

        // Creates both texts
        this.timeLeft = this.ecs.createEntity(62, 95).addText("00:00:00", this.textStyle);
        this.playersLeft = this.ecs.createEntity(158, 95).addText(null, this.textStyle);

        // Anchor it in 0,0
        this.title.sprite.anchor.set(0.0);
        
        // Add slices to panel
        this.card.setSlices(128, 0, 20, 0);

        // Set sprite image
        this.title.setImg(this.app.loader.resources["thePitSmall"]);
        
        this.updatePanel();
    }

    updatePanel() {
        const txt1Size = this.timeLeft.getSize();
        const txt2Size = this.playersLeft.getSize();
        this.card.setWidth(txt1Size.x + 64 + txt2Size.x);
    }

    onAttach() {
        // Add it to stage
        this.title.addStage(this.app);
        this.card.addStage(this.app);
        this.timeLeft.addStage(this.app);
        this.playersLeft.addStage(this.app);
    }

    onUpdate(deltaTime: number) { }

    onDetach() {
        this.title.remStage();
        this.card.remStage();
        this.timeLeft.remStage();
        this.playersLeft.remStage();
        this.listener.destroy();
        this.gameTimeListener.destroy();
    }

    // Sets remaining player texts
    onRemainPlayersMsg(msg: ServerMsg) {
        const { totalPlayers, remainingPlayers } = msg.content as RemainPlayersMsg;

        this.playersLeft.setText(`${remainingPlayers}/${totalPlayers} ALIVE`);
        this.updatePanel();
        return false;
    }

    // on every time update from backend
    // sets the clock to the correct time
    onGameTimeMsg(msg: ServerMsg) {
        const { hours, minutes, seconds } = msg.content as GameTimeMsg;

        this.timeLeft.setText(`${hours}:${minutes}:${seconds}`);
        this.updatePanel();
        return true;
    }
}

export { BattleStatusLayer };