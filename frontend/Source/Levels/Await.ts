import { Level } from "../Core/Level";
import { LobbyLevel } from "./Lobby";

// Layers imports
import { TextLayer } from "../Layers/Await/Text";
import { MapLayer } from "../Layers/Await/Basemap";
import { OverlayMap } from "../Layers/Await/Overlays";
import { LogsLayer } from "../Layers/Await/Log";

// Utils
import { v4 as uuidv4 } from "uuid";

// Web Clients imports
import { ScheduledGame } from "../Clients/Strapi";
import { GameStatus, Listener, MapData, msgTypes, ServerMsg } from "../Clients/Interfaces";
import { Logger } from "../Utils/Logger";
import { Resource } from "../Core/AssetLoader";
import { EngineContext } from "../Core/Interfaces";
import { MAIN_BG_COLOR } from "../Constants/Constants";

// Await level bg color
//const BLACK_BG_COLOR = 0x18215d;


class AwaitLevel extends Level {
    static LOG_REFRESH_TIME:number = 3.0;

    private gameStatusListener: Listener;
    private connectionListener: Listener;

    // count that resets every 3 seconds
    private refreshCount: number = 0.0;
    private playersInBattle:Set<string> = new Set();
    // Current Update Promisse
    private currentGame: ScheduledGame;
    private playerLog:LogsLayer;
    private textLayer:TextLayer;
    
    constructor(context: EngineContext, name: string = "Default", props: Record<string, any> = {}) {
        super(context, name, props);
        this.context.participantDetails.reset();
    }

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

        } catch(err) {
            Logger.fatal("Failed to request game status.")
            Logger.trace(JSON.stringify(err, null, 4));
            Logger.capture(err);
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
        this.context.app.renderer.backgroundColor = MAIN_BG_COLOR;

        // Connect background layer

        const mapDataResponse = await this.getMapData();
        const mapDataContent = mapDataResponse.content as MapData;
        const {levelCollider, levelMap, levelOverlays} = mapDataContent.mapData;
        
        this.layerStack.pushLayer(new MapLayer(
            this.ecs,
            this.context.app,
            this.context.res,
            levelMap
        ));

        // Load all overlays
        this.layerStack.pushLayer(
            new OverlayMap(
                this.ecs,                
                this.context.app,
                this.context.res,
                levelOverlays
            )
        );

        // Request current player details from strapi
        await this.loadPlayerDetails();

        this.playerLog = new LogsLayer(
            this.ecs,
            this.context.app,
            this.context
        );

        this.layerStack.pushOverlay(
            this.playerLog
        );

        this.textLayer = new TextLayer(
            this.ecs,
            this.context.app,
            this.context,
            this.currentGame
        );

        // Connect infos layer
        this.layerStack.pushLayer(this.textLayer);

        this.playBackgroundMusic(Level.AWAIT_SOUND);
    }

    async getMapData() {
        const response = await this.context.ws.request({
            uuid: uuidv4(),
            type: "request",
            content: {
                type: "map-data"
            }
        });

        return response;
    }

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

    async loadPlayerDetails () {
        
        try {
            // Request current game infos from strapi
            this.currentGame = await this.context.strapi.getGameById(this.props.gameId);
            await this.context.participantDetails.loadPlayerDetails(this.currentGame.scheduled_game_participants);
            this.context.assetLoader.loadSpriteSheets(Object.values(this.context.participantDetails.participants));
        } catch(err) {
            Logger.fatal("Cannot get game for current game id.");
            Logger.trace(JSON.stringify(err, null, 4));
            Logger.capture(err);
            this.context.close = true;
        }
    }

    updatePlayerList () {
        Object.values(this.context.participantDetails.participants).forEach( p => {
            if (p.name && p.name !== "undefined") {
                const playerKey = `${p.name}/${p.edition}`
                if (!this.playersInBattle.has(playerKey)) {
                    this.playersInBattle.add(playerKey);
                    this.playerLog.addPlayerToLog(p.name);
                }
            }
        });
        this.textLayer.updatePlayerList(Object.values(this.context.participantDetails.participants).length, this.currentGame.max_participants);
        
    }

    async onUpdate(deltaTime: number) {
        if (this.refreshCount >= AwaitLevel.LOG_REFRESH_TIME) {
            try {

                await this.loadPlayerDetails();
                this.updatePlayerList();
    
            } catch(e) {
                console.log("Failed to request game in strapi");
                console.log(JSON.stringify(e, null, 4));
            }           

            this.refreshCount -= AwaitLevel.LOG_REFRESH_TIME;
        }

        this.refreshCount += deltaTime;
    }

};

export { AwaitLevel };
