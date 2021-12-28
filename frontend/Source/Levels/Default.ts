import { Level } from "../Core/Level";
import { v4 as uuidv4 } from "uuid";

// Web client import
import { GameStatus } from "../Clients/Interfaces";

// Levels imports
import { AwaitLevel } from "./Await";
import { LobbyLevel } from "./Lobby";
import { NotFoundLevel } from "./NotFound";
import { ResultsLevel } from "./Results";

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
            console.log(response);
            await this.startLevels(content);

        } catch(e) {
            console.log(e);
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
                console.log(
                    "Expected lobby | awaiting | not-found but got: ", 
                    response.gameStatus
                );
                // Should show error screen

                this.context.close = true;
                break;
        }
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
};

export { DefaultLevel };