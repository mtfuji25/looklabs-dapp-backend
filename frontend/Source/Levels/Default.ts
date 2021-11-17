import { Level } from "../Core/Level";

// Web client import
import { requests, GameStatus } from "../Clients/Interfaces";
import { ServerResponse } from "../Clients/WebSocket";

// Levels imports
import { AwaitLevel } from "./Await";
import { LobbyLevel } from "./Lobby";

class DefaultLevel extends Level {

    onStart(): void {
        this.context.ws.request({
            type: requests.gameStatus
        })
        .then((response) => {
            const content = response.content as GameStatus;
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
                // Should load game not found level
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