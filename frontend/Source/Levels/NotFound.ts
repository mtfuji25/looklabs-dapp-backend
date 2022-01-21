import { Level } from "../Core/Level";
import { LobbyLevel } from "./Lobby";
import { AwaitLevel } from "./Await";

// Layers imports
import { TextLayer } from "../Layers/NotFound/Text";
import { MapLayer } from "../Layers/NotFound/Basemap";

// Utils
import { v4 as uuidv4 } from "uuid";

// Web Clients imports
import { GameStatus } from "../Clients/Interfaces";
import { BackgroundLayer } from "../Layers/NotFound/Background";
import { Logger } from "../Utils/Logger";

// Await level bg color
const BLACK_BG_COLOR = 0x000;

class NotFoundLevel extends Level {

    // Timers
    private fiveSecondsCounter: number = 0;

    onStart(): void {

        this.stopBackgroundMusic();
        // Sets bg color of main app
        this.context.app.renderer.backgroundColor = BLACK_BG_COLOR;


        this.layerStack.pushLayer(new BackgroundLayer(
            this.ecs,
            this.context.app,
            this.context.res
        ));

        this.layerStack.pushLayer(new TextLayer(
            this.ecs,
            this.context.app
        ));
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
                Logger.fatal("Expected lobby | awaiting | not-found but got: ", response.gameStatus);
                Logger.capture(new Error("Unexpected game status response: " + response.gameStatus));
                // Should show error screen

                this.context.close = true;
                break;
        }
    }

    async onUpdate(deltaTime: number) {

        if (this.fiveSecondsCounter >= 5) {

            try {
                const response = await this.context.ws.request(
                    {
                        uuid: uuidv4(),
                        type: "request",
                        content: {
                            type: "game-status"
                        }
                    }
                );

                const content = response.content as GameStatus;
                this.startLevels(content);
            } catch(err) {
                Logger.error("Cannot obtain current game-status from backend.");
                Logger.trace(JSON.stringify(err, null, 4));
                Logger.capture(err);
            }

            this.fiveSecondsCounter -= 5.0;
        }

        this.fiveSecondsCounter += deltaTime;
    }

    onClose(): void {}
};

export { NotFoundLevel };