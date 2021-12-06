import { Level } from "../Core/Level";

// Layers imports
import { TextLayer } from "../Layers/Await/Text";
import { MapLayer } from "../Layers/Await/Basemap";

// Web Clients imports
import { GameStatus, Listener, msgTypes, ServerMsg } from "../Clients/Interfaces";
import { ScheduledGameParticipant } from "../Clients/Strapi";
import { LobbyLevel } from "./Lobby";

// Await level bg color
const BLACK_BG_COLOR = 0x000;

class AwaitLevel extends Level {

    private listener: Listener;
    private conListener: Listener;

    onStart(): void {
        // Add msg listener
        this.listener = this.context.ws.addListener("game-status", (msg) => this.onServerMsg(msg));

        this.conListener = this.context.ws.addListener("connection", (ws) => {

            this.context.engine.loadLevel(
                new AwaitLevel(
                    this.context, "Lobby",
                    {
                        gameId: this.props.gameId
                    }
                )
            );

            return false;
        });

        // Sets bg color of main app
        this.context.app.renderer.backgroundColor = BLACK_BG_COLOR;

        this.connectLayers();
    }

    connectLayers(): void {
        this.layerStack.pushLayer(new MapLayer(
            this.ecs,
            this.context.app,
            this.context.res
        ));

        this.context.strapi.getGameById(this.props.gameId)
            .then((game) => {
                this.layerStack.pushLayer(new TextLayer(
                    this.ecs,
                    this.context.app,
                    this.context,
                    game
                ));
        });
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {
        this.listener.destroy()
        this.conListener.destroy();
    }

    onServerMsg(msg: ServerMsg) {
        let content: GameStatus;
        if (msg.content.msgType == msgTypes.gameStatus) {
            content = msg.content as GameStatus;
            if (content.gameStatus == "lobby") {
                this.context.engine.loadLevel(new LobbyLevel(
                    this.context,
                    "Lobby",
                    {
                        gameId: content.gameId
                    })
                )
            }
        }
        
        return false;
    }
};

export { AwaitLevel };
