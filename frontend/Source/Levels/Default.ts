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

    onStart(): void {
        this.context.ws.request({
            uuid: uuidv4(),
            type: "request",
            content: {
                type: "game-status"
            }
        })
        .then((response) => {
            const content = response.content as GameStatus;
            console.log(response)
            this.startLevels(content);
        })
        .catch((err) => {
            console.log(err);
            this.context.close = true;
        });
    
    }

    startLevels(response : GameStatus) {
        switch (response.gameStatus) {
            case "lobby":
                this.context.engine.loadLevel(
                    new LobbyLevel(
                        this.context, "Lobby",
                        {
                            gameId: response.gameId
                        }
                    )
                );
                break;

            case "awaiting":
                this.context.engine.loadLevel(
                    new AwaitLevel(
                        this.context, "Awaiting",
                        {
                            gameId: response.gameId
                        }
                    )
                );
                break;

            case "not-found":
                this.context.engine.loadLevel(
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