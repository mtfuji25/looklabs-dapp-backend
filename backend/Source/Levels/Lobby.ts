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
import { GameStatus, GameStatusListener, OnConnectionListener, PlayerNames, PlayerNamesListener, requests } from "../Clients/Interfaces";

class LobbyLevel extends Level {

    // Current running game id
    private gameId: number;

    // Current game participants
    private participants: ScheduledGameParticipant[] = [];
    private fighters: number = 0;

    // Tells when game is ready to play
    private ready: boolean = true;

    // one sec count for game timekeeping
    private oneSecCount: number = 0.0;

    // moment the game started
    private readonly initialDate: number = Date.now();

    // Current ws listener is
    private listener: GameStatusListener;
    private listenerNames: PlayerNamesListener;
    private conListener: OnConnectionListener;

    // Player names from API
    static playerNames: Record<string, string> = {};

    constructor(context: EngineContext, name: string, gameId: number) {
        super(context, name);

        this.gameId = gameId;

        LobbyLevel.playerNames = {};

        this.listener = this.context.ws.addListener("game-status", (msg) => this.onServerMsg(msg));
        this.listenerNames = this.context.ws.addListener("player-names", (msg) => this.onServerMsgNames(msg));

        this.conListener = this.context.ws.addListener("connection", (ws) => {
            setTimeout(() => {
                this.context.ws.send(ws, {
                    msgType: "remain-players",
                    remainingPlayers: this.fighters,
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
                console.log("Hei 0", err);
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

            let tokenAddr = (participant.nft_id).split('/')[0];
            let tokenId = Number((participant.nft_id).split('/')[1]);

            this.context.strapi.getParticipantDetails(tokenAddr, String(tokenId)).then(response => {
                responses.push({
                    participant: participant,
                    response: response
                });
                responseCounter++;
                console.log("Participant: ", participant, "Response: ", response)

                if (responseCounter == this.participants.length) {
                    // Put the map in the stack
                    this.layerStack.pushLayer(mapCollider);
        
                    responses.map(({ participant, response }) => {
                        const details = response;
                        LobbyLevel.playerNames[participant.nft_id] = details.name;
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
                                    }).catch((err) => console.log("Hei 1", JSON.stringify(err.request.data, null, 4)));

                                    // Final Rank log
                                    this.context.strapi.createLog({
                                        timestamp: Date.now().toString(),
                                        event: "final_rank",
                                        value: String(this.fighters),
                                        scheduled_game: this.gameId,
                                        scheduled_game_participant: result.scheduled_game_participant,
                                    }).catch((err) => console.log("Hei 2", JSON.stringify(err.request.data, null, 4)));

                                }).catch((err) => console.log("Hei 3", err));
                            },
                            (damage: number, participant: number) => {
                                // Damage log
                                this.context.strapi.createLog({
                                    timestamp: Date.now().toString(),
                                    event: "damage",
                                    value: String(damage),
                                    scheduled_game: this.gameId,
                                    scheduled_game_participant: participant
                                }).catch((err) => console.log("Hei 4", JSON.stringify(err.request.data, null, 4)));
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
                        }).catch((err) => console.log("Hei 5", JSON.stringify(err, null, 4)));
                    });
                }
            }).catch((err) => {
                console.log("Achamos");
                console.log(JSON.stringify(err));
            });
        });
    }

    onUpdate(deltaTime: number) {
        // update timer
        if (this.oneSecCount >= 1) {
            const { hours, minutes, seconds } = this.calculateTime();
            // send message containing current game time
            this.context.ws.broadcast({
                msgType: 'game-time',
                hours: hours, 
                minutes: minutes, 
                seconds: seconds
            })
            this.oneSecCount -= 1.0;
        }

        this.oneSecCount += deltaTime;

        // When game finished
        if (this.fighters == 1 && this.ready) {

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
        this.listenerNames.destroy();
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

    calculateTime(): Record<string, number> {
        const minTwoDigits = (n: number) => {
            return (n < 10 ? "0" : "") + String(n);
        };

        const difference = Date.now() - this.initialDate;

        let timeLeft = {};

        if (difference > 0) {
            timeLeft = {
                hours: minTwoDigits(
                    Math.floor((difference / (1000 * 60 * 60 * 24)) * 24)
                ),
                minutes: minTwoDigits(
                    Math.floor((difference / 1000 / 60) % 60)
                ),
                seconds: minTwoDigits(Math.floor((difference / 1000) % 60))
            };
        }

        return timeLeft;
    }
};

export { LobbyLevel };
