// Level imports
import { Level } from "../Core/Level";
import { AwaitLevel } from "./Await";

// Web clients imports
import { GameParticipantsResult, ScheduledGameParticipant } from "../Clients/Strapi";

// Interfaces imports
import { EngineContext } from "../Core/Interfaces";

// Layers import
import { PlayerLayer } from "../Layers/Lobby/Player";
import { MapColliderLayer } from "../Layers/Lobby/MapCollider";
import { ReplyableMsg } from "../Clients/WebSocket";
import { GameStatus, GameStatusListener, OnConnectionListener, requests } from "../Clients/Interfaces";

class LobbyLevel extends Level {

    // Current running game id
    private gameId: number;

    // Current game participants
    private participants: ScheduledGameParticipant[] = [];
    private fighters: number = 0;

    // Tells when game is ready to play
    private ready: boolean = false;

    // Current ws listener is
    private listener: GameStatusListener;
    private conListener: OnConnectionListener;

    constructor(context: EngineContext, name: string, gameId: number) {
        super(context, name);

        this.gameId = gameId;

        this.listener = this.context.ws.addListener("game-status", (msg) => this.onServerMsg(msg));
        this.conListener = this.context.ws.addListener("connection", (ws) => {
            this.context.ws.send(ws, {
                msgType: "remain-players",
                remainingPlayers: this.participants.length,
                totalPlayers: this.participants.length
            });

            return false;
        });
    }

    onStart(): void {
        this.context.strapi.getGameById(this.gameId)
            .then((game) => {
                game.scheduled_game_participants.map((participant) => {
                    this.participants.push(participant);
                    this.fighters++;
                });
                this.startGame();
            }).catch((err) => {
                console.log(err);
                this.context.close = true;
            });
    }

    startGame() {
        const mapCollider = new MapColliderLayer(this.ecs);
        const grid = mapCollider.getSelf().getGrid();

        // Put the map in the stack
        this.layerStack.pushLayer(mapCollider);

        // Initial broadcast for players length
        this.context.ws.broadcast({
            msgType: "remain-players",
            remainingPlayers: this.participants.length,
            totalPlayers: this.participants.length
        });

        this.participants.map((participant) => {
            const player = new PlayerLayer(
                this.ecs, this.context.ws,
                participant.nft_id, participant.id, grid, 
                (result: GameParticipantsResult) => {
                    this.ready = false;
                    this.layerStack.popLayer(player);
                    // Esse vai para produção
                    console.log("Matou caramba")
                    this.context.strapi.createParticipantResult(result).then(() => {
                        this.ready = true
                    }).catch((err) => console.log(err));
                    // Shoud be after create result
                    this.fighters--;
                    this.context.ws.broadcast({
                        msgType: "remain-players",
                        remainingPlayers: this.fighters,
                        totalPlayers: this.participants.length
                    });
                },
                participant.name
            );
            grid.addDynamic(player.getSelf());
            this.layerStack.pushLayer(player)
        });

        // Tells that lobby is ready to play
        this.ready = true;
    }

    onUpdate(deltaTime: number) {
        // When game finished
        if (this.fighters <= 1 && this.ready) {

            // Find the last remain player
            this.layerStack.layers.map((layer) => {
                if (layer instanceof PlayerLayer) {

                    // Block update for re-running
                    this.ready = false;

                    // Get status component
                    const status = layer.getSelf().getStatus();

                    // Tells front-ends that there is only one player
                    this.context.ws.broadcast({
                        msgType: "remain-players",
                        remainingPlayers: this.fighters,
                        totalPlayers: this.participants.length
                    });

                    // Create last participant result
                    this.context.strapi.createParticipantResult({
                        scheduled_game_participant: layer.strapiID,
                        survived_for: Math.floor(status.survived),
                        kills: Math.floor(status.kills),
                        health: Math.ceil(status.health)
                    }).then(() => {

                        // Tells frontends that is return to await from this gameId
                        const msg: GameStatus = {
                            msgType: "game-status",
                            gameId: this.gameId,
                            lastGameId: 0,
                            gameStatus: "awaiting"
                        };
                        this.context.ws.broadcast(msg);

                        // Change to await level
                        this.context.engine.loadLevel(new AwaitLevel(this.context, "Await"));
                    });
                }
            });
        }
    }

    onClose(): void {
        this.layerStack.destroy();
        this.listener.destroy();
        this.conListener.destroy();
    }

    onServerMsg(msg: ReplyableMsg) {

        if (msg.content.type == requests.gameStatus) {
            const reply: GameStatus = {
                msgType: "game-status",
                gameId: this.gameId,
                lastGameId: 0,
                gameStatus: "lobby"
            }

            msg.reply(reply);
        }

        return true;
    }
};

export { LobbyLevel };
