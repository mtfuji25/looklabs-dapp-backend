// Level imports
import { Level } from "../Core/Level";

// Await level imports
import { AwaitLevel } from "./Await";

// Web clients imports
import { GameParticipantsResult, ParticipantDetails, ScheduledGame, ScheduledGameParticipant } from "../Clients/Strapi";

// Interfaces imports
import { EngineContext } from "../Core/Interfaces";
import { Layer } from "../Core/Layer";

// Layers import
import { PlayerLayer } from "../Layers/Lobby/Player";
import { MapColliderLayer } from "../Layers/Lobby/MapCollider";

// Websocket related imports
import { ReplyableMsg } from "../Clients/WebSocket";
import { 
    requests, 
    GameStatus,
    PlayerNames,
    GameStatusListener,
    PlayerNamesListener,
    OnConnectionListener,
    GameStateListener,
    GameState,
    GameStateTypes,
    MapData,
    MapDataListener,
} from "../Clients/Interfaces";
import { WebSocket } from "ws";
import { sleep } from "../Utils/Sleep";
import { Logger } from "../Utils/Logger";

// Map
import levelCollider from "../Assets/level_collider.json";
import levelMap from "../Assets/level_map.json";
import levelOverlays from "../Assets/level_overlays.json";

//
// Types
//
type OnDieEvent = { result: GameParticipantsResult, killer: number, nftId:string,  details?:ParticipantDetails };
type OnDamageEvent = { damage: number, participant: number, nftId:string, health:number,  details?:ParticipantDetails };

interface TimeLeft {
    hours: string;
    minutes: string;
    seconds: string;
}

export enum GameStateValues {
    SPAWN,
    COUNTDOWN3,
    COUNTDOWN2,
    COUNTDOWN1,
    COUNTDOWN0,
    FIGHT
}

//
// Constants
//

// Delay to await when new client connect to respond
// Represented in miliseconds
const ON_WS_CONNECTION_RESPONSE_DELAY: number = 1000;
const INTRO_SETUP_DELAY: number = 1000;
const INTRO_SPAWN_DELAY: number  = 4000;
const INTRO_COUNTDOWN_DELAY: number = 1000;

//
// Level implementation
//
class LobbyLevel extends Level {

    // Current running game id
    private gameId: number;

    private gameState:GameStateValues = GameStateValues.SPAWN;

    // Number of figthers remaining in the lobby
    private fighters: number = 0;

    // Current game participants
    private participants: ScheduledGameParticipant[] = [];

    // Counters
    private oneSecondCounter: number = 0.0;

    // Store game start time
    private initialDate: number;

    // WebSockets listeners
    private mapDataListener: MapDataListener;
    private gameNamesListener: PlayerNamesListener;
    private gameStatusListener: GameStatusListener;
    private wsConnectionListener: OnConnectionListener;
    private gameStateListener: GameStateListener;

    // Event Dispatchers queue
    private dieEventQueue: OnDieEvent[] = [];
    private damageEventQueue: OnDamageEvent[] = [];
    
    // Web Event Dispatchers queue
    private dieEventRequestQueue: Promise<void>[] = [];
    private damageEventRequestQueue: Promise<void>[] = [];

    // Player names from API
    static playerNames: Record<string, string> = {};

    // Players layers storage
    private players: PlayerLayer[] = [];

    constructor(context: EngineContext, name: string, gameId: number) {
        super(context, name);

        // Set current game id for game status request purpose and
        // strapi informations requests
        this.gameId = gameId;

        // Clear static variables with name from the players in the game
        // to make sure that no residues from last game remains alive
        LobbyLevel.playerNames = {};

        // Adding WebSockets listeners
        this.mapDataListener = this.context.ws.addListener(
            "map-data", (msg) => this.onMapDataMsg(msg)
        );

        this.gameStatusListener = this.context.ws.addListener(
            "game-status", (msg) => this.onGameStatusMsg(msg)
        );

        this.gameNamesListener = this.context.ws.addListener(
            "player-names", (msg) => this.onGameNamesMsg(msg)
        );

        this.gameStateListener = this.context.ws.addListener(
            "game-state", (msg) => this.OnGameStateMsg(msg)
        );

        this.wsConnectionListener = this.context.ws.addListener(
            "connection", (ws) => this.onWsConnectionEvent(ws)
        );
    }

    // Default level's start method, called when engine loads the level
    async onStart(): Promise<void> {
        let game: ScheduledGame;

        try {
            // Request the game using gameId passed in the constructor
            game = await this.context.strapi.getGameById(this.gameId);

            game.scheduled_game_participants.map((participant) => {
                this.participants.push(participant);
                this.fighters++;
            });

            // Effectivelly starts the game
            await this.startGame();
        } catch(err) {
            Logger.fatal("Failed to request game in strapi");
            Logger.trace(JSON.stringify(err, null, 4));

            Logger.capture(err);

            // Closes the engine
            this.context.close = true;
        }
    }

    async startGame(): Promise<void> {

        // Creates game map layer
        const mapCollider = new MapColliderLayer(this.ecs);

        // Extracts grid component from mapCollider
        const grid = mapCollider.getSelf().getGrid();

        // Initial broadcast for players length
        // Tells frontends number of player in lobby
        this.context.ws.broadcast({
            msgType: "remain-players",
            remainingPlayers: this.participants.length,
            totalPlayers: this.participants.length
        });

        await Promise.all(this.participants.map(async (participant) => {

            // Extracts the address and id of token
            const tokenId = (participant.nft_id).split('/')[1];
            const tokenAddr = (participant.nft_id).split('/')[0];

            // Request participant details from strapi
            const details = await this.context.strapi.getParticipantDetails(tokenAddr, tokenId);
            if (details.name.indexOf (tokenId) == -1) {
                details.name = `${details.name} #${tokenId}`;
            }
            details.edition = Number(tokenId);

            // Add current player name to the playerNames storage
            LobbyLevel.playerNames[participant.nft_id] = details.name;

            // Lambda to process when some palyer dies
            const onDieLambda = (result: GameParticipantsResult, killer: number, nftId: string, details:ParticipantDetails) => {

                // Extracts the player ID to filter in layers
                const strapId = result.scheduled_game_participant;

                let deadPlayer: PlayerLayer;

                Logger.info("Processing dead player: ", player.strapiID);

                // Find the dead player and remove it from current player storage
                this.players = this.players.filter((player) => {
                    if (player.strapiID === strapId) {
                        deadPlayer = player;
                        return false;
                    }

                    return true;
                });

                if (!deadPlayer) return;

                // Removes the dead player from the layerstack
                this.layerStack.popLayer(deadPlayer);
                this.fighters--;

                // Tells frontend how many palyers remains
                this.context.ws.broadcast({
                    msgType: "remain-players",
                    remainingPlayers: this.fighters,
                    totalPlayers: this.participants.length
                });

                this.dieEventQueue.push({
                    result: result,
                    killer: killer,
                    nftId: nftId,
                    details: details
                });
            };

            // Lambda to process when some player dies
            const onDamageLambda = (damage: number, participant: number, nftId:string, health:number, details:ParticipantDetails) => {
                this.damageEventQueue.push({
                    damage: damage,
                    participant: participant,
                    nftId: nftId,
                    health: health,
                    details: details
                });
            };

            // Creates current player
            const player = new PlayerLayer(
                // Basic tools passed to the layer
                this.ecs, this.context.ws,

                // Ids and grid
                participant.nft_id, participant.id, grid,

                // Lambdas and player details
                onDieLambda, onDamageLambda, details
            );

            // Add player to the current map
            grid.addDynamic(player.getSelf());

            // Iserts player in the layer stack
            this.layerStack.pushLayer(player);

            // Saves a copy of player for on die use
            this.players.push(player);

            // Create player entrant log in strapi
            try {
                await this.context.logStorage.createLog({
                    event: "entrants",
                    timestamp: Date.now(),
                    scheduled_game: this.gameId,
                    player_id: participant.nft_id,
                    stats: this.getFormattedStats(details),
                    name: details.name,
                    scheduled_game_participant: participant.id,
                });
            } catch(err) {
                Logger.error(
                    "Failed to create game entrant log for player: ",
                    participant.id
                );
                Logger.trace(JSON.stringify(err, null, 4));
                Logger.capture(err);
            }
        }));

        // Put the map in the stack
        this.layerStack.pushLayer(mapCollider);

        // sleep and start intro
        await sleep(INTRO_SETUP_DELAY);

        // start spawning entities on the map
        this.gameState = GameStateValues.SPAWN;
        this.context.ws.broadcast({
            msgType: "game-state",
            gameId: this.gameId,
            gameState: "spawn"
        });

        await sleep(INTRO_SPAWN_DELAY);
        
        // run final count down
        const countdown:GameStateTypes[] = ["countdown0","countdown1","countdown2","countdown3"];
        const countdownStates:GameStateValues[] = [GameStateValues.COUNTDOWN0,GameStateValues.COUNTDOWN1,GameStateValues.COUNTDOWN2,GameStateValues.COUNTDOWN3];
        while (countdown.length > 0) {
            const count = countdown.pop();
            const state = countdownStates.pop();
            this.gameState = state;
            this.context.ws.broadcast({
                msgType: "game-state",
                gameId: this.gameId,
                gameState: count
            });
            await sleep(INTRO_COUNTDOWN_DELAY);
        }   

        //sleep to display FIGHT! text
        await sleep(INTRO_COUNTDOWN_DELAY);

        //start game
        this.initialDate =  Date.now();
        this.gameState = GameStateValues.FIGHT;
        this.context.ws.broadcast({
            msgType: "game-state",
            gameId: this.gameId,
            gameState: "fight"
        });
    }

    async onUpdate(deltaTime: number) {

        if (this.gameState != GameStateValues.FIGHT) return;
        
        if ( this.participants.length <= 1 ) {
            const msg: GameStatus = {
                msgType: "game-status",
                gameId: this.gameId,
                lastGameId: 0,
                gameStatus: "restarting"
            };
            this.context.ws.broadcast(msg);

            // Change to await level
            this.context.engine.loadLevel(new AwaitLevel(this.context, "Await"));
            Logger.error(`Game ${this.gameId} was loaded with 1 or less players`);
            return;
        } 

      
        // Update timer
        if (this.oneSecondCounter >= 1) {
            const { hours, minutes, seconds } = this.getFormatedTime();

            // Send message containing current game time
            this.context.ws.broadcast({
                msgType: 'game-time',
                hours: hours, 
                minutes: minutes, 
                seconds: seconds
            })
            this.oneSecondCounter -= 1.0;
        }
        this.oneSecondCounter += deltaTime;

        // Checks if there are events to dispatch
        this.dieEventQueue.map((event) => {

            const diePromise: Promise<void> = new Promise(async (resolve, reject) => {
                try {
                    await this.context.strapi.createParticipantResult({
                        scheduled_game_participant: event.result.scheduled_game_participant,
                        survived_for: Math.floor(event.result.survived_for),
                        kills: Math.floor(event.result.kills),
                        health: Math.ceil(event.result.health)
                    });
                } catch(err) {
                    Logger.error(
                        "Failed to create game participant result for player: ",
                        event.result.scheduled_game_participant
                    );
                    Logger.trace(JSON.stringify(err, null, 4));
                    Logger.capture(err);
                    reject();
                }

                try {
                    await this.context.logStorage.createLog({
                        event: "kills",
                        timestamp: Date.now(),
                        value: event.result.scheduled_game_participant,
                        scheduled_game: this.gameId,
                        scheduled_game_participant: event.killer,
                        player_id: event.nftId,
                        name: event.details.name,
                        stats: this.getFormattedStats(event.details),
                    });
                } catch(err) {
                    Logger.error(
                        "Failed to dispatch kill log for player: ",
                        event.result.scheduled_game_participant
                    );
                    Logger.trace(JSON.stringify(err, null, 4));
                    Logger.capture(err);
                    reject();
                }
                
                try {
                    await this.context.logStorage.createLog({
                        event: "final_rank",
                        timestamp: Date.now(),
                        value: this.fighters,
                        player_id: event.nftId,
                        stats: this.getFormattedStats(event.details),
                        scheduled_game: this.gameId,
                        name: event.details.name,
                        scheduled_game_participant: event.result.scheduled_game_participant,
                    });
                } catch(err) {
                    Logger.error(
                        "Failed to dispatch final rank log for player: ",
                        event.result.scheduled_game_participant
                    );
                    Logger.trace(JSON.stringify(err, null, 4));
                    Logger.capture(err);
                    reject();
                }
                resolve();
            })

            diePromise.catch((err) => {
                Logger.error(
                    "Failed to push in damage event queue new async: ",
                    event.result.scheduled_game_participant
                );
                Logger.trace(JSON.stringify(err, null, 4));
                Logger.capture(err);
            });

            // Push new promisse in the dispatch queue
            this.dieEventRequestQueue.push(
                diePromise
            );
        });

        // Empty all dispatched events
        this.dieEventQueue = [];

        // Checks if there are events to dispatch
        this.damageEventQueue.map((event) => {

            const damagePromise: Promise<void> = new Promise(async (resolve, reject) => {
                try {
                    await this.context.logStorage.createLog({
                        event: "damage",
                        timestamp: Date.now(),
                        value: event.damage,
                        player_id: event.nftId,
                        stats: this.getFormattedStats(event.details, event.health),
                        scheduled_game: this.gameId,
                        name: event.details.name,
                        scheduled_game_participant: event.participant
                    });
                } catch(err) {
                    Logger.error(
                        "Failed to dispatch damage log for player: ",
                        event.participant
                    );
                    Logger.trace(JSON.stringify(err, null, 4));
                    Logger.capture(err);
                    reject();
                }
                resolve();
            });

            damagePromise.catch((err) => {
                Logger.error(
                    "Failed to push in damage event queue new async: ",
                    event.participant
                );
                Logger.trace(JSON.stringify(err, null, 4));
                Logger.capture(err);
            });

            // Push new promisse in the dispatch queue
            this.damageEventRequestQueue.push(
                damagePromise
            );
        });

        this.damageEventQueue = [];

        // When game finished
        if (this.fighters == 1) {
            // Find the last remain player
            const lastFigther = this.players[0];

            // Tells front-ends that there is only one player
            this.context.ws.broadcast({
                msgType: "remain-players",
                remainingPlayers: this.fighters,
                totalPlayers: this.participants.length
            });

            // Stores the start of await time of requests
            const startRequestTime = Date.now();
            // Await all opened request to change to other level
            try {
                await Promise.all(this.dieEventRequestQueue);
                await Promise.all(this.damageEventRequestQueue);
            } catch(err) {
                Logger.error("Unable to complete save results from request queue.");
                Logger.trace(JSON.stringify(err, null, 4));
                Logger.capture(err);
            }

            await sleep(1000);

            // Get last player status
            const lastPlayerStatus = lastFigther.getSelf().getStatus();
            
            // Creates the log for the last player
            await this.context.strapi.createParticipantResult({
                scheduled_game_participant: lastFigther.strapiID,
                survived_for: Math.floor(lastPlayerStatus.survived + 500 + Math.random() * 1500),
                kills: Math.floor(lastPlayerStatus.kills),
                health: Math.ceil(lastPlayerStatus.health)
            });

            // Winner log
            try {
                await this.context.logStorage.createLog({
                    event: "winners",
                    timestamp: Date.now(),
                    scheduled_game: this.gameId,
                    player_id: lastFigther.playerID,
                    stats: this.getFormattedStats(lastFigther.details),
                    name: lastFigther.details.name,
                    scheduled_game_participant: lastFigther.strapiID,
                });
            } catch(err) {
                Logger.error(
                    "Failed to dispatch winner log for player: ",
                    lastFigther.strapiID
                );
                Logger.trace(JSON.stringify(err, null, 4));
                Logger.capture(err);
            }

            const eleapsedRequestsTime = Date.now() - startRequestTime;

            // In case that request last less than five seconds, await remaining time
            if (eleapsedRequestsTime < 5000) {
                await sleep(5000 - eleapsedRequestsTime);
            }

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
        }
    }

    async runPendings(deltaTime: number) {
        switch (this.gameState) {
            case GameStateValues.SPAWN:
                break;
            
            case GameStateValues.COUNTDOWN3:
            case GameStateValues.COUNTDOWN2:
            case GameStateValues.COUNTDOWN1:                
            case GameStateValues.COUNTDOWN0:
                break;    
            case GameStateValues.FIGHT:
                this.ecs.onUpdate(deltaTime);
                break;
        }
        
        // Update all level's layers
        this.layerStack.layers.map((layer: Layer) => {
            layer.onUpdate(deltaTime);
        })
    }


    // Default level's close method, called when engine
    // switch between levels or close itself
    onClose(): void {
        // Listeners destruction
        this.gameNamesListener.destroy();
        this.gameStatusListener.destroy();
        this.wsConnectionListener.destroy();
        this.gameStateListener.destroy();
    }

    onMapDataMsg(msg: ReplyableMsg): boolean {

        console.log("onMapDataMsg");

        // Check the veracity of message type
        if (msg.content.type === requests.mapData) {

            // Generates the reply
            const reply: MapData = {
                msgType: "map-data",
                gameId: this.gameId,
                mapData: {
                    levelCollider,
                    levelMap,
                    levelOverlays
                }
            };

            // Send the reply to the author of request
            msg.reply(reply);
        }

        // Handles the event, doesn't allow event propagation
        // in the event listeners queue
        return true;
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
                gameStatus: "lobby"
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

    OnGameStateMsg (msg: ReplyableMsg): boolean {

        let state:GameStateTypes = "fight";
        if (this.gameState == GameStateValues.COUNTDOWN0) state = "countdown0";
        if (this.gameState == GameStateValues.COUNTDOWN1) state = "countdown1";
        if (this.gameState == GameStateValues.COUNTDOWN2) state = "countdown2";
        if (this.gameState == GameStateValues.COUNTDOWN3) state = "countdown3";
        if (this.gameState == GameStateValues.SPAWN) state = "spawn";

        if (msg.content.type == requests.gameState) {
            const reply: GameState = {
                msgType: "game-state",
                gameId: this.gameId,
                gameState: state
            }
            msg.reply(reply);
        }

        return true;
    }

    // Handles all requests from frontends that relate with current player names
    onWsConnectionEvent(ws: WebSocket): boolean {

        setTimeout(
            () => {
                this.context.ws.send(ws, {
                    msgType: "remain-players",
                    remainingPlayers: this.fighters,
                    totalPlayers: this.participants.length
                });
            }, ON_WS_CONNECTION_RESPONSE_DELAY
        );

        // Doesn't handles the event, allow event propagation
        // in the event listeners queue
        return false;
    }

    getFormattedStats (details:ParticipantDetails, health?:number): string {
        const attributesMap: Record<string, any> = {};
       details.attributes.map((attribute) => {
            attributesMap[attribute.trait_type] = attribute.value;
        });
        if (health) {
            health = (100 * health) / PlayerLayer.MAX_HEALTH;
            if (health < 0) health = 0;

            return `Attack: ${attributesMap['Attack']},Defence: ${attributesMap['Defence']},Speed: ${attributesMap['Speed']},Health: ${health}`;
        }
        return `Attack: ${attributesMap['Attack']},Defence: ${attributesMap['Defence']},Speed: ${attributesMap['Speed']}`;
    }

    getFormatedTime(): TimeLeft {
        // Small lambda to return string with two digits of a number
        const minTwoDigits = (n: number) => {
            return (n < 10 ? "0" : "") + String(n);
        };

        // Time difference between start game time
        const difference = Date.now() - this.initialDate;

        let timeLeft: TimeLeft;

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
