import { Layer } from "../../Core/Layer";
import { ECS } from "../../Core/Ecs/Core/Ecs";

import { Application, IBitmapTextStyle, ITextStyle } from "pixi.js";
import { Sprite } from "../../Core/Ecs/Components/Sprite";
import { Panel } from "../../Core/Ecs/Components/Panel";
import {  GameTimeMsg, Listener, RemainPlayersMsg, ServerMsg } from "../../Clients/Interfaces";
import { EngineContext } from "../../Core/Interfaces";
import { BMPText } from "../../Core/Ecs/Components/BMPText";

class BattleStatusLayer extends Layer {
    private app: Application;
    private title: Sprite;
    private card: Panel;
    private timeLeft: BMPText;
    private playersLeft: BMPText;

    // context
    private context: EngineContext;

    private listener: Listener;

    private gameTimeListener: Listener;

    private readonly textStyle: Partial<IBitmapTextStyle> = {
        fontName: "SpaceMono-Bold",
        fontSize: 16,
        tint: 0x000000,
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
        this.timeLeft = this.ecs.createEntity().addBMPText("00:00:00", this.textStyle);
        this.playersLeft = this.ecs.createEntity().addBMPText(" ", this.textStyle);

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
        this.card.setWidth(txt1Size.x + 70 + txt2Size.x);
    }

    onAttach() {
        // Add it to stage
        this.timeLeft.setPos(62, 90);
        this.playersLeft.setPos(158, 90);
        
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