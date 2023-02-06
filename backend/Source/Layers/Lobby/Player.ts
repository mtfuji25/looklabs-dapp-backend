import { Layer } from "../../Core/Layer";

// Ecs and Components imports
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Grid } from "../../Core/Ecs/Components/Grid";

// Web clients imports
import { WebSocket } from "ws";
import { WSClient } from "../../Clients/WebSocket";
import { StatusResult } from "../../Core/Ecs/Components/Status";
import { rad2deg, Vec2, clamp } from "../../Utils/Math";
import { OnConnectionListener, PlayerCommand } from "../../Clients/Interfaces";

// Kill feed actions
import killFeed from "../../Assets/KillFeed.json";
import { GameParticipantsResult, ParticipantDetails } from "../../Clients/Strapi";

import { Logger } from "../../Utils/Logger";
import { PlayerActions } from "./PlayerActions";
import spawnPos from "../../Assets/SpawnPositions.json";

class PlayerLayer extends Layer {

    public static MAX_ATTACK:number = 18;
    public static MAX_SPEED:number = 0.055;
    public static MAX_DEFENSE:number = 5;
    public static MAX_HEALTH:number = 180;

    // Current web socket server client
    private wsClient: WSClient;
    private conListener: OnConnectionListener;

    // Player ID
    public playerID: string;
    public strapiID: number;

    // initial info for player
    public details: ParticipantDetails;

    // Current grid
    private grid: Grid;

    // For spawn point selection
    static playerCount: number = 0;

    // Die fn
    public dieFn: (result: GameParticipantsResult, killer: number, nftId: string, details?:ParticipantDetails ) => void;
    public damageFn: (damage: number, participant: number, nftId: string, health:number, details?:ParticipantDetails ) => void;

    constructor(ecs: ECS,
        wsContext: WSClient,
        id: string,
        strapiID: number,
        grid: Grid,
        dieFn: (result: GameParticipantsResult, killer: number, nftId: string, details?:ParticipantDetails) => void,
        damageFn: (damage: number, participant: number, nftId: string, health:number, details?:ParticipantDetails) => void,
        details: ParticipantDetails) {

        super(`Player${id}`, ecs);

        this.wsClient = wsContext;
        this.playerID = id;
        this.grid = grid;
        this.dieFn = dieFn;
        this.damageFn = damageFn;
        this.self.name = details.name;
        this.self.strapiId = strapiID;
        this.strapiID = strapiID;
        this.details = details;
        

        const tokenId = Number((this.playerID).split('/')[1]);
        // make necessary adjustments for characters, like Wolf.game, which are loaded from one basic JSON file
        details.edition = tokenId;
        if (details.name.indexOf (tokenId.toString()) == -1) {   
            details.name = `${details.name} #${tokenId}`;
            this.self.name = details.name;
        }
        // create a record of mapped attributes, so we can use the attributes returned more easily
        // eg: {speed: 20, torso: 'BeetleTorso, name: 'beetle33'}

        const attributesMap: Record<string, any> = {};

        const tiers = ["beta", "delta", "sigma", "alpha"];

        this.details.attributes.map((attribute) => {
            attributesMap[attribute.trait_type] = attribute.value;
        });
        if (!attributesMap["Tier"] || tiers.indexOf(attributesMap["Tier"].toLowerCase()) == -1) attributesMap["Tier"] = "beta";

        
        const status = this.self.addStatus(
            // Attack
            // 20 * (attributesMap["Attack"] / 100.0),
            clamp(PlayerLayer.MAX_ATTACK * (attributesMap["Attack"] / 100.0), PlayerLayer.MAX_ATTACK * 0.45, PlayerLayer.MAX_ATTACK),
            // Speed
            // 0.04 * (attributesMap["Speed"] / 100.0),
            clamp(PlayerLayer.MAX_SPEED * (attributesMap["Speed"] / 100.0), PlayerLayer.MAX_SPEED * 0.6, PlayerLayer.MAX_SPEED),
            // Health
            PlayerLayer.MAX_HEALTH,
            // Defense
            // 5 * (attributesMap["Defence"] / 100.0),
            clamp(PlayerLayer.MAX_DEFENSE * (attributesMap["Defence"] / 100.0), PlayerLayer.MAX_DEFENSE * 0.5, PlayerLayer.MAX_DEFENSE),
            // Cooldown
            0.5,
            // Creature
            attributesMap["Creature"],
            // Name
            this.self.name,
            //Tier
            attributesMap["Tier"].toLowerCase()
        );

        status.setOnDie((status) => this.onDie(status));
        status.setOnDamage((damage) => this.onDamage(damage));

        // Add rigibody for current entity
        this.self.addRigidbody(
            grid.intervalX * 1.7,
            grid.intervalY * 1.7,
        );

        //make position wrap around, in case of too many players
        this.self.getTransform().setPos(
            spawnPos.pos[PlayerLayer.playerCount % spawnPos.pos.length].x,
            spawnPos.pos[PlayerLayer.playerCount % spawnPos.pos.length].y

        );
        PlayerLayer.playerCount++;

        this.self.addBehavior();
        this.self.addStrategy();

        // Start to listen for connection
        // this.conListener = this.wsClient.addConListener((ws) => this.onWsConnection(ws))
        this.conListener = this.wsClient.addListener("connection", (ws) => this.onWsConnection(ws));
    }


    onAttach(): void {
        // Create player entity in new client
        this.wsClient.broadcast(this.getBaseMsg("create"));
    }

    onUpdate(deltaTime: number) {
        const { critical } = this.self.getStatus();
        const { attacking, healing } = this.self.getBehavior();
        const { velocity } = this.self.getRigidbody();

        let walkH = PlayerActions.DIRECTION_RIGHT;
        if (velocity.x < 0) walkH = PlayerActions.DIRECTION_LEFT;
        else if (velocity.x == 0) walkH = Math.random() > 0.5 ? PlayerActions.DIRECTION_RIGHT : PlayerActions.DIRECTION_LEFT;

        if (walkH == PlayerActions.DIRECTION_RIGHT) {
            if (attacking) {
                if (critical) {
                    this.wsClient.broadcast(this.getBaseMsg("update", PlayerActions.ATTACK_RIGHT_CRITICAL));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", PlayerActions.ATTACK_RIGHT));
                }
            } else {
                if (healing) {
                    this.wsClient.broadcast(this.getBaseMsg("update", PlayerActions.WALK_RIGHT_HEALING));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", PlayerActions.WALK_RIGHT));
                }
            }
    
        } else if (walkH == PlayerActions.DIRECTION_LEFT) {
            if (attacking) {
                if (critical) {
                    this.wsClient.broadcast(this.getBaseMsg("update", PlayerActions.ATTACK_LEFT_CRITICAL));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", PlayerActions.ATTACK_LEFT));
                }
            } else {
                if (healing) {
                    this.wsClient.broadcast(this.getBaseMsg("update", PlayerActions.WALK_LEFT_HEALING));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", PlayerActions.WALK_LEFT));
                }
            }
        }
    }

    onDetach() {

        // Delete player entity in client
        this.wsClient.broadcast(this.getBaseMsg("delete"));

        // Remove connection listener
        // this.wsClient.remConListener(this.conListener);
        this.conListener.destroy();

        // Removes itself from the grid
        this.grid.removeDynamic(this.self);

        // Removes itself from ecs
        this.self.destroy();
    }

    onWsConnection(ws: WebSocket) {
        this.wsClient.send(ws, this.getBaseMsg("create"));

        // Doesn't handle the event
        return false;
    }

    getBaseMsg(type: "create" | "update" | "delete", action: number = 0): PlayerCommand {
        const status = this.self.getStatus();
        const { pos } = this.self.getTransform();

        return {
            msgType: "enemy",
            type: type,
            id: this.playerID,
            pos: { x: pos.x, y: pos.y },
            action: action,
            health: status.health
        };
    }

    // When player dies callback
    onDie(status: StatusResult) {
        Logger.info("Player Died: ", this.name)
        Logger.info("Results: ", status);
        const killerName = this.self.getStatus().lastHit.name;
        const killerId = this.self.getStatus().lastHit.strapiId;

        this.wsClient.broadcast({
            killed: this.self.name,
            killer: killerName,
            action: killFeed.items[killFeed.items.length * Math.random() | 0],
            msgType: "kill"
        });

        this.dieFn({
            scheduled_game_participant: this.strapiID,
            survived_for: Math.floor(status.survived),
            kills: Math.floor(status.kills),
            health: Math.floor(status.health),
        }, killerId, this.playerID, this.details );
    }

    // When player takes a hit callback
    onDamage(damage: number) {
       const status = this.self.getStatus();
       this.damageFn(damage, this.strapiID, this.playerID, status.health, this.details );
    }
}

export { PlayerLayer };
