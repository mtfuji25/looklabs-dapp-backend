import { Level } from "../Core/Level";

// Web client import
import { requests, GameStatus } from "../Clients/Interfaces";

// Levels imports
import { AwaitLevel } from "./Await";
import { LobbyLevel } from "./Lobby";
import { NotFoundLevel } from "./NotFound";

class DefaultLevel extends Level {

    onStart(): void {
        // this.context.ws.request({
        //     type: requests.gameStatus
        // })
        // .then((response) => {
        //     const content = response.content as GameStatus;
        //     this.startLevels(content);
        // })
        // .catch((err) => {
        //     console.log(err);
        //     this.context.close = true;
        // });

        // this.context.ws.onReady(() => {
        //     this.context.ws.request({

        //     }).then();
        // });
        this.startLevels({
            gameId:1,
            gameStatus: "lobby",
            lastGameId: 1,
            msgType: "game-status"
        })
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