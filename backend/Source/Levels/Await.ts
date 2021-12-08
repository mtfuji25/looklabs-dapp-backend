// Level imports
import { Level } from "../Core/Level";
import { LobbyLevel } from "./Lobby";

// Scheduled game interface
import { ReplyableMsg } from "../Clients/WebSocket";
import { GameStatus, GameStatusListener, PlayerNames, PlayerNamesListener, requests } from "../Clients/Interfaces";

class AwaitLevel extends Level {

    // WebSocket listener id
    private listener: GameStatusListener;
    private listenerNames: PlayerNamesListener;

    // Current game id
    private gameId: number = 0;

    // If found some game
    private gameFound: boolean = false;

    onStart(): void {
        // Add WebSocket listener
        this.listener = this.context.ws.addListener("game-status", (msg) => this.onServerMsg(msg));
        this.listenerNames = this.context.ws.addListener("player-names", (msg) => this.onServerMsgNames(msg));
        this.checkForGame();
    }

    checkForGame() {
        this.context.strapi.getNearestGame()
            .then((game) => {
                if (!game) {
                    console.log("No scheduled game, awaiting ...");
                    setTimeout(() => this.checkForGame(), 60000);
                } else {
                    console.log("Game found, awaiting to start ...");
                    this.gameFound = true;
                    const now = Date.now();
                    const nextGame = Date.parse(game.game_date);

                    this.gameId = game.id;
                    if (nextGame - now <= 120000) {
                        setTimeout(() => this.startLobby(), nextGame - now);
                    }
                    else
                        setTimeout(() => this.checkForGame(), 60000);
                }
            })
            .catch((err) => {
                console.log("Failed while seraching game in strapi. Will try again in 60s");
                console.log(JSON.stringify(err, null, 4));

                // Closes the engine
                //this.context.close = true;
                // just try again, maybe just a hick up
                setTimeout(() => this.checkForGame(), 60000);
            });
    }

    startLobby() {
        console.log("Initializing new game ...");
        const msg: GameStatus = {
            msgType: "game-status",
            gameId: this.gameId,
            lastGameId: 0,
            gameStatus: "lobby"
        };
        this.context.ws.broadcast(msg);
        this.context.engine.loadLevel(
            new LobbyLevel(this.context, "Lobby", this.gameId)
        );
    }

    onUpdate(deltaTime: number) { }

    onClose(): void {
        // Removes msg listener
        // this.context.ws.remMsgListener(this.listener);
        this.listener.destroy()
    }

    onServerMsg(msg: ReplyableMsg) {

        if (msg.content.type == requests.gameStatus) {
            const reply: GameStatus = {
                msgType: "game-status",
                gameId: this.gameId,
                lastGameId: 0,
                gameStatus: this.gameFound ? "awaiting" : "not-found"
            }

            msg.reply(reply);
        }

        return true;
    }

    onServerMsgNames(msg: ReplyableMsg) {
        if (msg.content.type == requests.playerNames) {
            const reply: PlayerNames = {
                msgType: "player-names",
                gameId: this.gameId,
                names: {
                    ...LobbyLevel.playerNames
                }
            }

            msg.reply(reply);
        }

        return true;
    }
};

export { AwaitLevel };
