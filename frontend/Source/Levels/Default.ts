import { Level } from "../Core/Level";
import { v4 as uuidv4 } from "uuid";

// Web client import
import { GameStatus } from "../Clients/Interfaces";

// Levels imports
import { AwaitLevel } from "./Await";
import { LobbyLevel } from "./Lobby";
import { NotFoundLevel } from "./NotFound";
import { ResultsLevel } from "./Results";
import { Logger } from "../Utils/Logger";

class DefaultLevel extends Level {

    async onStart(): Promise<void> {

        // Waits for the ws client connection be stabilished
        await this.context.ws.whenReady();

        try {
            const response = await this.context.ws.request({
                uuid: uuidv4(),
                type: "request",
                content: {
                    type: "game-status"
                }
            });

            const content = response.content as GameStatus;
            Logger.trace(JSON.stringify(response, null, 4));
            await this.startLevels(content);

        } catch(err) {
            Logger.fatal("Failed to request game status.")
            Logger.trace(JSON.stringify(err, null, 4));
            Logger.capture(err);
            this.context.close = true;
        }
    }

    async startLevels(response : GameStatus) {
        switch (response.gameStatus) {
            case "lobby":
                await this.context.engine.loadLevel(
                    new LobbyLevel(
                        this.context, "Lobby",
                        {
                            gameId: response.gameId
                        }
                    )
                );
                break;

            case "awaiting":
                await this.context.engine.loadLevel(
                    new AwaitLevel(
                        this.context, "Awaiting",
                        {
                            gameId: response.gameId
                        }
                    )
                );
                break;

            case "not-found":
                await this.context.engine.loadLevel(
                    new NotFoundLevel(
                        this.context, "Awaiting",
                        {
                            gameId: response.gameId
                        }
                    )
                );
                break;

            default:
                Logger.fatal(
                    "Expected lobby | awaiting | not-found but got: ", 
                    response.gameStatus
                );
                Logger.capture(new Error("Unexpected game status response: " + response.gameStatus));
                // Should show error screen

                this.context.close = true;
                break;
        }
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
};

export { DefaultLevel };