import { Level } from "../core/level";
import { ScheduledGame } from "../clients/strapi";
import { LobbyLevel } from "./lobby";

class AwaitLevel extends Level {

    private handleStrapiId: number = 0;

    private gameId: number = 0;

    onStart(): void {
        this.context.strapiClient.getNearestGame()
            .then((game) => {
                if (!game) {
                    console.log("No scheduled game, awaiting ...");
                    this.handleStrapiId = this.context.strapiClient.addMsgListener(
                        (msg) => this.handleStrapiMsg(msg)
                    );
                } else {
                    console.log("Game found, awaiting to start ...");
                    const now = Date.now();
                    const nextGame = Date.parse(game.game_date);

                    this.gameId = game.id;
                    setTimeout(() => this.startLobby(), nextGame - now);
                }
            }).catch((err) => {
                console.log(err);
                this.context.closeRequest = true;
            });
    }

    handleStrapiMsg(game: ScheduledGame) {
        console.log("Game found, awaiting to start ...");
        const now = Date.now();
        const nextGame = Date.parse(game.game_date);

        this.gameId = game.id;
        setTimeout(() => this.startLobby(), nextGame - now);

        this.context.strapiClient.remMsgListener(this.handleStrapiId);

        return false;
    }

    startLobby() {
        console.log("Initing new game ...")
        this.context.engine.loadLevel(
            new LobbyLevel(this.context, "Lobby", this.gameId)
        );
    }

    onUpdate(deltaTime: number) { }

    onClose(): void { }
};

export { AwaitLevel };