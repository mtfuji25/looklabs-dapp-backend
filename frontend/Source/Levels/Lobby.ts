// Level import
import { Level } from "../Core/Level";

// Constants
import { MAIN_BG_COLOR } from "../Constants/Constants";

// Layers imports
import { MapLayer } from "../Layers/Lobby/Map";
import { PlayerLayer } from "../Layers/Lobby/Player";
import { ViewContext, ViewLayer } from "../Layers/Lobby/View";
import { BattleStatusLayer } from "../Layers/Lobby/Status";
import { LogsLayer } from "../Layers/Lobby/Log";
import { GameStatus, Listener, RemainPlayersMsg, ServerMsg } from "../Clients/Interfaces";
import { ResultsLevel } from "./Results";
import { OverlayMap } from "../Layers/Lobby/Overlays";

interface LobbyLevelContext extends ViewContext {
    // View properties
    zoom: number;
    offsetX: number;
    offsetY: number;
}

class LobbyLevel extends Level {

    private listener: Listener;
    private listenerRemain: Listener;
    private conListener: Listener;
    private remaining: number = 0;
    private responseParticipant: any | null = null;
    private responseWinner: any | null = null;
    private requested: boolean = false;
    private showDownStart: boolean = false;

    private levelContext: LobbyLevelContext = {
        // View properties
        zoom: 0.0,
        offsetX: 0.0,
        offsetY: 0.0
    };

    onStart(): void {

        this.listener = this.context.ws.addListener("game-status", (msg) => this.onStatus(msg));
        this.listenerRemain = this.context.ws.addListener("remain-players", (msg) => this.onRemainPlayersMsg(msg));
        this.conListener = this.context.ws.addListener("connection", (ws) => {

            this.context.engine.loadLevel(
                new LobbyLevel(
                    this.context, "Lobby",
                    {
                        gameId: this.props.gameId,
                        playerNames: this.props.playerNames
                    }
                )
            );

            return false;
        });

        // Sets bg color of main app
        this.context.app.renderer.backgroundColor = MAIN_BG_COLOR;

        // Pushs view controller
        this.layerStack.pushLayer(
            new ViewLayer(this.ecs, this.levelContext, this.context.app, this.context.inputs)
        );

        // Pushs map generator
        this.layerStack.pushLayer(
            new MapLayer(
                this.ecs,
                this.levelContext,
                this.context.app,
                this.context.res
            )
        );

        // Pushs the player controller
        this.layerStack.pushLayer(
            new PlayerLayer(
                this.ecs,
                this.levelContext,
                this.context.app,
                this.context.ws,
                this.context.strapi,
                this.context.res,
            )
        );

        // Load all overlays
        this.layerStack.pushLayer(
            new OverlayMap(
                this.ecs,
                this.levelContext,
                this.context.app,
                this.context.res
            )
        );

        this.layerStack.pushOverlay(
            new BattleStatusLayer(
                this.ecs,
                this.context.app,
                this.context
            )
        );

        this.layerStack.pushOverlay(
            new LogsLayer(
                this.ecs,
                this.context.app,
                this.context
            )
        );

        this.playBackgroundMusic(Level.LOBBY_SOUND);
    }

    onUpdate(deltaTime: number) {
        
        if (this.remaining > 0 &&  this.remaining <= 2 && !this.showDownStart) {
            this.showDownStart = true;
            // switch BG music to showdown
            this.playBackgroundMusic(Level.SHOWDOWN_SOUND);
        }

        if (this.remaining == 1 && (!this.requested)) {
            this.requested = true;
            this.context.strapi.getGameParticipants(this.props.gameId).then((participants) => {
                this.responseParticipant = participants;
                let splitId = (participants[0].nft_id).split('/')[1];
                let address = (participants[0].nft_id).split('/')[0];
                if(splitId > 50) splitId -= 50;
                if(splitId == 0) splitId += 1;
                this.context.strapi.getParticipantDetails(address, splitId).then((participant) => {
                    this.responseWinner = participant;
                })
            })
        }
    }

    onClose(): void {
        this.layerStack.destroy();
        this.conListener.destroy();
        this.listener.destroy();
        this.listenerRemain.destroy();
    }

    onRemainPlayersMsg(msg: ServerMsg) {
        
        const { totalPlayers, remainingPlayers } = msg.content as RemainPlayersMsg;
        
        this.remaining = remainingPlayers;

        return false;
    }

    onStatus(status: ServerMsg) {

        status.content = status.content as GameStatus;

        if (status.content.gameStatus == "awaiting") {
            console.log("Running")
            this.context.engine.loadLevel(new ResultsLevel(
                this.context, "Results",
                {
                    gameId: status.content.gameId,
                    responseParticipant: this.responseParticipant,
                    responseWinner: this.responseWinner,
                }
            ));
        }

        return false;
    }
}

export { LobbyLevel, LobbyLevelContext };