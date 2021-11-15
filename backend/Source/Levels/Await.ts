// Level imports
import { Level } from "../Core/Level";
//import { LobbyLevel } from "./Lobby";

// Scheduled game interface
import { ScheduledGame } from "../Clients/Strapi";
import { ReplyableMsg } from "../Clients/WebSocket";

class AwaitLevel extends Level {

    // WebSocket listener id
    private listener: number = 0;

    private gameId: number = 0;
    private gameFound: boolean = false;

    onStart(): void {
        // Add WebSocket listener
        this.listener = this.context.ws.addMsgListener((msg) => this.onServerMsg(msg));

        this.context.strapi.getNearestGame()
            .then((game) => {
                if (!game) {
                    console.log("No scheduled game, awaiting ...");
                    this.context.strapi.onWebhook(
                        (game) => this.onStrapiHook(game)
                    );
                } else {
                    console.log("Game found, awaiting to start ...");
                    this.gameFound = true;
                    const now = Date.now();
                    const nextGame = Date.parse(game.game_date);

                    this.gameId = game.id;
                    setTimeout(() => this.startLobby(), nextGame - now);
                }
            })
            .catch((err) => {
                console.log("Failed while seraching game in strapi.");
                console.log(err);

                // Closes the engine
                this.context.close = true;
            });
    }

    onStrapiHook(game: ScheduledGame) {
        console.log("Game found, awaiting to start ...");
        this.gameFound = true;
        const now = Date.now();
        const nextGame = Date.parse(game.game_date);

        this.gameId = game.id;
        setTimeout(() => this.startLobby(), nextGame - now);
    }

    startLobby() {
        console.log("Initing new game ...")
        // this.context.engine.loadLevel(
        //     new LobbyLevel(this.context, "Lobby", this.gameId)
        // );
    }

    onUpdate(deltaTime: number) { }

    onClose(): void {
        // Removes msg listener
        this.context.ws.remMsgListener(this.listener);
    }

    onServerMsg(msg: ReplyableMsg) {

        if (msg.content.type == "game-data") {
            msg.reply({
                gameId: this.gameId,
                gameFound: this.gameFound
            })
        }

        return true;
    }
};

export { AwaitLevel };