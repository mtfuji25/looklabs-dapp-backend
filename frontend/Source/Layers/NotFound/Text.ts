import { Layer } from "../../Core/Layer";
import { v4 as uuidv4 } from "uuid";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

// Interfaces
import { EngineContext } from "../../Core/Interfaces";

// Ecs and Components
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";
import { GameStatus, requests } from "../../Clients/Interfaces";
import { LobbyLevel } from "../../Levels/Lobby";
import { AwaitLevel } from "../../Levels/Await";

class TextLayer extends Layer {
    private app: Application;
    private subtitle: Text;
    private percentX: number;
    private percentY: number;

    private screenX: number;
    private screenY: number;

    private context: EngineContext;

    // Styles
    private readonly titleStyle: Partial<ITextStyle> = {
        fontFamily: "Space Mono",
        fontSize: "130px",
        fill: 0xffffff,
        align: "center",
        fontWeight: "700"
    };

    // count that resets every second
    private fiveSecCount: number = 0.0;

    constructor(ecs: ECS, app: Application, context: EngineContext) {
        super("TesteLayer", ecs);

        this.app = app;
        this.context = context;

        // sets percents
        this.percentX = this.app.view.width / 100.0;
        this.percentY = this.app.view.height / 100.0;

        this.screenX = this.app.view.width;
        this.screenY = this.app.view.height;
    }

    renderText(text: Text, y: number) {
        text.setPos(
            this.percentX * 50 - text.text.width / 2.0,
            this.percentY * y - text.text.height / 2.0
        );
        text.addStage(this.app);
    }

    onAttach() {
        this.subtitle = this.ecs.createEntity().addText("NO GAME FOUND", this.titleStyle);

        this.renderText(this.subtitle, 50);
    }

    startLevels(response: GameStatus) {
        switch (response.gameStatus) {
            case "lobby":
                this.context.engine.loadLevel(
                    new LobbyLevel(this.context, "Lobby", {
                        gameId: response.gameId
                    })
                );
                break;

            case "awaiting":
                this.context.engine.loadLevel(
                    new AwaitLevel(this.context, "Awaiting", {
                        gameId: response.gameId
                    })
                );
                break;

            case "not-found":
                break;

            default:
                console.log("Expected lobby | awaiting | not-found but got: ", response.gameStatus);
                // Should show error screen

                this.context.close = true;
                break;
        }
    }

    onUpdate(deltaTime: number) {
        if(this.app.view.width !== this.screenX || this.app.view.height !== this.screenY) {
            // resets percentages
            this.percentX = this.app.view.width / 100.0;
            this.percentY = this.app.view.height / 100.0;

            this.screenX = this.app.view.width;
            this.screenY = this.app.view.height;

            this.subtitle.setPos(
                this.percentX * 50 - this.subtitle.text.width / 2.0,
                this.percentY * 50 - this.subtitle.text.height / 2.0
            );
        }

        if (this.fiveSecCount >= 5) {
            this.context.ws
                .request({
                    uuid: uuidv4(),
                    type: "request",
                    content: {
                        type: "game-status"
                    }
                })
                .then((response) => {
                    const content = response.content as GameStatus;
                    this.startLevels(content);
                })
                .catch((err) => {
                    console.log(err);
                    this.context.close = true;
                });
            this.fiveSecCount -= 5.0;
        }

        this.fiveSecCount += deltaTime;
    }

    onDetach() {
        this.self.destroy();
    }
}

export { TextLayer };
