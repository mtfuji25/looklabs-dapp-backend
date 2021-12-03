// Level imports
import { Level } from "../Core/Level";
import { AwaitLevel } from "./Await";

// Web clients imports
import { GameParticipantsResult, ParticipantDetails, ScheduledGameParticipant } from "../Clients/Strapi";

// Interfaces imports
import { EngineContext } from "../Core/Interfaces";

// Layers import
import { PlayerLayer, spawnPos } from "../Layers/Lobby/Player";
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
            setTimeout(() => {
                this.context.ws.send(ws, {
                    msgType: "remain-players",
                    remainingPlayers: this.participants.length,
                    totalPlayers: this.participants.length
                });
            }, 1000);

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
        // Initial broadcast for players length
        this.context.ws.broadcast({
            msgType: "remain-players",
            remainingPlayers: this.participants.length,
            totalPlayers: this.participants.length
        });

        let responseCounter = 0;
        const responses: { participant: ScheduledGameParticipant, response: ParticipantDetails }[] = [];

        this.participants.map((participant) => {

            let tokenId = Number((participant.nft_id).split('/')[1]);

            if(tokenId > 50) tokenId -= 50;
            if (tokenId == 0)
                tokenId = 1;
            if (tokenId == 50)
                tokenId = 49;

            this.context.strapi.getParticipantDetails(Number(tokenId)).then(response => {

                responses.push({
                    participant: participant,
                    response: response
                });
                responseCounter++;

                if (responseCounter == this.participants.length) {
                    // Put the map in the stack
                    this.layerStack.pushLayer(mapCollider);
        
                    responses.map(({ participant, response }) => {
                        const details = response;
                        const player = new PlayerLayer(
                            this.ecs, this.context.ws,
                            participant.nft_id, participant.id, grid, 
                            (result: GameParticipantsResult, killer: number) => {
                                this.ready = false;
                                this.layerStack.popLayer(player);
                                
                                this.fighters--;
                                this.context.ws.broadcast({
                                    msgType: "remain-players",
                                    remainingPlayers: this.fighters,
                                    totalPlayers: this.participants.length
                                });

                                this.context.strapi.createParticipantResult(result).then(() => {
                                    this.ready = true;

                                    // Kill Log
                                    this.context.strapi.createLog({
                                        timestamp: Date.now().toString(),
                                        event: "kills",
                                        value: String(result.scheduled_game_participant),
                                        scheduled_game: this.gameId,
                                        scheduled_game_participant: killer,
                                    }).catch((err) => console.log(JSON.stringify(err.request.data, null, 4)));

                                    // Final Rank log
                                    this.context.strapi.createLog({
                                        timestamp: Date.now().toString(),
                                        event: "final_rank",
                                        value: String(this.fighters),
                                        scheduled_game: this.gameId,
                                        scheduled_game_participant: result.scheduled_game_participant,
                                    }).catch((err) => console.log(JSON.stringify(err.request.data, null, 4)));

                                }).catch((err) => console.log(err));
                            },
                            (damage: number, participant: number) => {
                                // Damage log
                                this.context.strapi.createLog({
                                    timestamp: Date.now().toString(),
                                    event: "damage",
                                    value: String(damage),
                                    scheduled_game: this.gameId,
                                    scheduled_game_participant: participant
                                }).catch((err) => console.log(JSON.stringify(err.request.data, null, 4)));
                            },
                            details
                        );
                        grid.addDynamic(player.getSelf());
                        this.layerStack.pushLayer(player);

                        // Entrants log
                        this.context.strapi.createLog({
                            timestamp: Date.now().toString(),
                            event: "entrants",
                            scheduled_game: this.gameId,
                            scheduled_game_participant: participant.id,
                        }).catch((err) => console.log(JSON.stringify(err.request.data, null, 4)));
                    });
                    this.ready = true;
                }
            });
        });
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

                        setTimeout(() => {
                            // Winner log
                            this.context.strapi.createLog({
                                timestamp: Date.now().toString(),
                                event: "winners",
                                scheduled_game: this.gameId,
                                scheduled_game_participant: layer.strapiID,
                            })

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
                       }, 5000);
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
