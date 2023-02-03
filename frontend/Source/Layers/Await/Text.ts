import { Layer } from "../../Core/Layer";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

// Web clients
import { ScheduledGame } from "../../Clients/GameApi";

// Interfaces
import { EngineContext } from "../../Core/Interfaces";

// Ecs and Components
import { ECS, Entity } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";
import { Sprite } from "../../Core/Ecs/Components/Sprite";
import { Logger } from "../../Utils/Logger";


class TextLayer extends Layer {
    private app: Application;
    private title: Sprite;
    private subtitle: Text;
    private countdown: Text;
    private entered: Text;
    private percentY: number;
    private currentGame: ScheduledGame;
    private context: EngineContext;

    private screenX: number;
    private screenY: number;

    // Current Update Promisse
    private updateRequest: Promise<ScheduledGame> = new Promise<ScheduledGame>(() => { });

    // Styles
    private readonly titleStyle: Partial<ITextStyle> = {
        fontFamily: "dealers",
        fontSize: "144px",
        fill: 0xFFFFFF,
        align: "center",
        fontWeight: "400"
    };

    private readonly textStyle: Partial<ITextStyle> = {
        fontFamily: "Space Mono",
        fontSize: 25,
        fill: 0x000,
        align: "center",
        fontWeight: "700",
        lineHeight: 37
    };

    // count that resets every second
    private oneSecCount: number = 0.0;

    // count that resets every 5 seconds
    private fiveSecCount: number = 0.0;

    constructor(
        ecs: ECS,
        app: Application,
        context: EngineContext,
        currentGame: ScheduledGame
    ) {
        super("TesteLayer", ecs);

        this.app = app;
        this.currentGame = currentGame;
        this.context = context;

        // sets percents
        this.percentY = this.app.screen.height / 100.0;

        this.screenX = this.app.view.clientWidth;
        this.screenY = this.app.view.clientHeight;

        // Add sprite to it
        this.title = this.ecs.createEntity().addSprite(this.app.loader.resources["thepit"]);

        // Anchor it in 0,0
        this.title.sprite.anchor.set(0.0);

        // Add it to stage
        this.title.addStage(this.app);
    }

    renderText(text: Text, y: number) {
        text.setPos(
            (this.screenX - text.text.width) * 0.5,
            y * this.percentY
        );
        text.addStage(this.app);
    }

    _onResize() {
        this.title.setPos((this.screenX - this.title.sprite.width) * 0.5, 8.125 * this.percentY);

        this.countdown.setPos(
            (this.screenX - (this.countdown.text.width * 0.95)) * 0.5,
            this.percentY * 40
        );
        this.entered.setPos(
            (this.screenX - this.entered.text.width * 0.95) * 0.5,
            this.percentY * 59.25
        );
        this.subtitle.setPos(
            (this.screenX - this.subtitle.text.width * 0.95) * 0.5,
            this.percentY * 33.375
        );

    }

    updatePlayerList(count: number, max: number) {
        const maxPlayers = max ? max : 100;
        this.entered.setText(`ENTERED: ${count} (MAX ${maxPlayers})`);

    }

    onAttach() {

        const { hours, minutes, seconds } = this.calculateTimeLeft(
            this.currentGame.game_date
        );


        this.subtitle = this.ecs.createEntity().addText("NEXT BATTLE STARTS IN", this.textStyle);

        const maxPlayers = this.currentGame.max_participants ? this.currentGame.max_participants : 100;

        this.entered = this.ecs.createEntity().addText(
            `ENTERED: ${this.currentGame.scheduled_game_participants.length} (MAX ${maxPlayers})`,
            this.textStyle
        );


        this.countdown = this.ecs.createEntity().addText(
            `${hours}:${minutes}:${seconds}`,
            this.titleStyle
        );

        this.renderText(this.subtitle, 33.375);
        this.renderText(this.countdown, 40);
        this.renderText(this.entered, 59.25);

        this._onResize();
    }

    onUpdate(deltaTime: number) {
        // on window resize 
        if (this.app.view.clientWidth !== this.screenX || this.app.view.clientHeight !== this.screenY) {
            this.percentY = this.app.view.clientHeight / 100.0;

            this.screenX = this.app.view.clientWidth;
            this.screenY = this.app.view.clientHeight;


            this._onResize();
        }


        if (this.oneSecCount >= 1) {

            const { hours, minutes, seconds } = this.calculateTimeLeft(
                this.currentGame.game_date
            );

            if (!seconds || !minutes || !hours) {

                // if seconds is undefined, make everything dissapear
                this.countdown.setText("");
                this.subtitle.setText("");
                this.entered.setText("");

                this.title.sprite.visible = false;

            } else {

                this.countdown.setText(`${hours}:${minutes}:${seconds}`);
                // this.countdown.setPos(            
                //     (this.screenX - (this.countdown.text.width * 0.95)) * 0.5,
                //     this.percentY * 40
                // );
            }
            this.oneSecCount -= - 1.0;
        }

        if (this.fiveSecCount >= 5) {
            //this.updateRequest = this.context.strapi.getGameById(this.currentGame.id);

            // this.updateRequest.then((updatedGame) => {
            //     const maxPlayers = updatedGame.max_participants ? updatedGame.max_participants : 100;
            //     this.entered.setText(`ENTERED: ${updatedGame.scheduled_game_participants.length} (MAX ${maxPlayers})`);
            // });

            // this.updateRequest.catch((e) => {
            //     Logger.info("Level destroyed while requesting, aborting reponse action...");
            // });

            this.fiveSecCount -= 5.0;
        }

        this.oneSecCount += deltaTime;
        this.fiveSecCount += deltaTime;
    }

    async onDetach() {
        // Abort possible update request in course
        await this.updateRequest;

        this.countdown.remStage();
        this.subtitle.remStage();
        this.entered.remStage();

        this.title.remStage();
    }

    calculateTimeLeft(targetDate: string): Record<string, number> {
        const minTwoDigits = (n: number) => {
            return (n < 10 ? "0" : "") + n;
        };

        // The + signs return the number representation of date object
        const difference = (+new Date(targetDate)) - (+new Date());

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
}

export { TextLayer };