// Level imports
import { Level } from "../Core/Level";

// Lobby level import
import { LobbyLevel } from "./Lobby";

// WebSocket client related imports
import { ReplyableMsg } from "../Clients/WebSocket";
import { 
    requests,
    GameStatus,
    PlayerNames,
    GameStatusListener,
    PlayerNamesListener,
} from "../Clients/Interfaces";

// Strapi related imports
import { ScheduledGame } from "../Clients/Strapi";
import { Logger } from "../Utils/Logger";

//
// Constants
//

// How much time between each search for new game in strapi.
// Represented in miliseconds
const GAME_SEARCH_INTERVAL: number = 60000;

// How much time from now to consider game valid to load.
// Represented in miliseconds
const GAME_VALID_INTERVAL: number = 120000;

//
// Level implementation
//
class AwaitLevel extends Level {

    // WebSockets listeners
    private gameNamesListener: PlayerNamesListener;
    private gameStatusListener: GameStatusListener;

    // Current game id
    private gameId: number = 0;

    // If found some game
    private gameFound: boolean = false;

    // Default level's start method, called when engine loads the level
    async onStart(): Promise<void> {
        // Create WebSockets listeners
        this.gameStatusListener = this.context.ws.addListener(
            "game-status", (msg) => this.onGameStatusMsg(msg)
        );

        this.gameNamesListener = this.context.ws.addListener(
            "player-names", (msg) => this.onGameNamesMsg(msg)
        );

        // Try to find next valid game
        await this.checkForGame();
    }

    async checkForGame(): Promise<void> {

        let game: ScheduledGame;
        
        // Request nearest game for strapi
        try {
            game = await this.context.strapi.getNearestGame();

        } catch(err) {
            Logger.warn(`Failed while seraching game in strapi. Will try again in ${GAME_SEARCH_INTERVAL}s`);
            Logger.trace(JSON.stringify(err, null, 4));
            Logger.capture(err);

            setTimeout(() => this.checkForGame(), GAME_SEARCH_INTERVAL);
        }

        // If there is no game, retry the search in some interval
        if (!game) {
            Logger.info("No scheduled game, awaiting ...");
            setTimeout(() => this.checkForGame(), GAME_SEARCH_INTERVAL);
        } else {
            Logger.info("Game found, awaiting to start ...");

            // Set game found true for game status requests purpose
            this.gameFound = true;

            // Extracts time difference for next game
            const now = Date.now();
            const nextGame = Date.parse(game.game_date);

            // Set game id for game status requests purpose
            this.gameId = game.id;

            if (nextGame - now <= GAME_VALID_INTERVAL) {
                // Set lobby loading process to start in remaining time to next game
                setTimeout(() => this.startLobby(), nextGame - now);
            } else {
                setTimeout(() => this.checkForGame(), GAME_SEARCH_INTERVAL);
            }
        }
    }

    startLobby(): void {
        Logger.info("Initializing new game ...");

        // Generate game status message
        const msg: GameStatus = {
            msgType: "game-status",
            gameId: this.gameId,
            lastGameId: 0,
            gameStatus: "lobby"
        };

        // Tells frontends that will start a lobby
        this.context.ws.broadcast(msg);

        // Load ne lobby level
        this.context.engine.loadLevel(
            new LobbyLevel(this.context, "Lobby", this.gameId)
        );
    }

    // Default level's update method, called once per frame
    onUpdate(deltaTime: number): void { }

    // Default level's close method, called when engine
    // switch between levels or close itself
    onClose(): void {
        // Removes current levels related listeners
        this.gameNamesListener.destroy()
        this.gameStatusListener.destroy()
    }

    // Handles all requests from frontends that relate with current game-status
    onGameStatusMsg(msg: ReplyableMsg): boolean {

        // Check the veracity of message type
        if (msg.content.type === requests.gameStatus) {

            // Generates the reply
            const reply: GameStatus = {
                msgType: "game-status",
                gameId: this.gameId,
                lastGameId: 0,
                gameStatus: this.gameFound ? "awaiting" : "not-found"
            };

            // Send the reply to the author of request
            msg.reply(reply);
        }

        // Handles the event, doesn't allow event propagation
        // in the event listeners queue
        return true;
    }

    // Handles all requests from frontends that relate with current player names
    onGameNamesMsg(msg: ReplyableMsg): boolean {

        // Check the veracity of message type
        if (msg.content.type == requests.playerNames) {

            // Generates the reply
            const reply: PlayerNames = {
                msgType: "player-names",
                gameId: this.gameId,
                names: {
                    // LobbyLevel contains one static variable to store
                    // all names from last game, it's reseted in every 
                    // game start.
                    ...LobbyLevel.playerNames
                }
            };

            // Send the reply to the author of request
            msg.reply(reply);
        }

        // Handles the event, doesn't allow event propagation
        // in the event listeners queue
        return true;
    }
};

export { AwaitLevel };
