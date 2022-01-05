import { Level } from "../Core/Level";
import { LobbyLevel } from "./Lobby";

// Layers imports
import { TextLayer } from "../Layers/Await/Text";
import { MapLayer } from "../Layers/Await/Basemap";

// Utils
import { v4 as uuidv4 } from "uuid";

// Web Clients imports
import { ScheduledGame } from "../Clients/Strapi";
import { GameStatus, Listener, msgTypes, ServerMsg } from "../Clients/Interfaces";

// Await level bg color
const BLACK_BG_COLOR = 0x000;

class AwaitLevel extends Level {

    private gameStatusListener: Listener;
    private connectionListener: Listener;

    async onStart(): Promise<void> {

        try {
            // Request current game status from backend
            const response = await this.context.ws.request({
                uuid: uuidv4(),
                type: "request",
                content: {
                    type: "game-status"
                }
            });

            // Cast the response to corret type
            const content = response.content as GameStatus;

            // If in lobby changes to lobby level
            if (content.gameStatus == "lobby") {
                await this.context.engine.loadLevel(new LobbyLevel(
                    this.context, "Lobby",
                    {
                        gameId: content.gameId
                    }
                ))
            }

        } catch(e) {
            console.log(e);
            this.context.close = true;
        }

        // Add backend message listeners
        this.gameStatusListener = this.context.ws.addListener(
            "game-status",
            (msg) => this.onGameStatusMessage(msg)
        );
        
        this.connectionListener = this.context.ws.addListener(
            "connection",
            (event) => this.onConnectionEvent(event)
        );

        // Sets bg color of main app
        this.context.app.renderer.backgroundColor = BLACK_BG_COLOR;

        // Connect background layer
        this.layerStack.pushLayer(new MapLayer(
            this.ecs,
            this.context.app,
            this.context.res
        ));

        // Request current game infos from strapi
        let game: ScheduledGame;

        try {
            game = await this.context.strapi.getGameById(this.props.gameId);
        } catch(e) {
            console.log(e);
            this.context.close = true;
        }

        // Connect infos layer
        this.layerStack.pushLayer(new TextLayer(
            this.ecs,
            this.context.app,
            this.context,
            game
        ));
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {

        // Destroy event and message listeners
        this.gameStatusListener.destroy();
        this.connectionListener.destroy();
    }

    // Handles all game-status messages from backend
    onGameStatusMessage(msg: ServerMsg) {
        let content: GameStatus;

        // Check the veracity of message type
        if (msg.content.msgType == msgTypes.gameStatus) {

            // Perfom the cast to corret msg type
            content = msg.content as GameStatus;

            // Checks for the interest type of message
            if (content.gameStatus == "lobby") {

                // Changes the level
                this.context.engine.loadLevel(new LobbyLevel(
                    this.context,
                    "Lobby",
                    {
                        gameId: content.gameId
                    }
                ));
            }
        }

        // Doesn't handles the event, allow event propagation
        // in the event listeners queue
        return false;
    }

    // Handles all connection events with backend
    onConnectionEvent(event: Event) {
        
        this.context.engine.loadLevel(
            new AwaitLevel(
                this.context, "Await",
                {
                    gameId: this.props.gameId
                }
            )
        );

        // Handles the event, doesn't allow event propagation
        // in the event listeners queue
        return true;
    }
};

export { AwaitLevel };
