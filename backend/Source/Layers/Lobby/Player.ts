import { Layer } from "../../Core/Layer";

// Ecs and Components imports
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Grid } from "../../Core/Ecs/Components/Grid";

// Web clients imports
import { WebSocket } from "ws";
import { WSClient } from "../../Clients/WebSocket";
import { StatusResult } from "../../Core/Ecs/Components/Status";
import { rad2deg, Vec2 } from "../../Utils/Math";
import { OnConnectionListener, PlayerCommand } from "../../Clients/Interfaces";

// Kill feed actions
import killFeed from "../../Assets/KillFeed.json";
import { GameParticipantsResult, ParticipantDetails } from "../../Clients/Strapi";

import spawnPositions from "../../Assets/SpawnPositions.json";

class PlayerLayer extends Layer {

    // Current web socket server client
    private wsClient: WSClient;
    private conListener: OnConnectionListener;

    // Player ID
    public playerID: string;
    public strapiID: number;

    // initial info for player
    private details: ParticipantDetails;

    // Current grid
    private grid: Grid;

    // For spawn point selection
    static playerCount: number = 0;

    // Die fn
    public dieFn: (result: GameParticipantsResult, killer: number) => void;
    public damageFn: (damage: number, participant: number) => void;

    constructor(ecs: ECS,
        wsContext: WSClient,
        id: string,
        strapiID: number,
        grid: Grid,
        dieFn: (result: GameParticipantsResult, killer: number) => void,
        damageFn: (damage: number, participant: number) => void,
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

        // Add status component to current entity
        // this.self.addStatus(
        //     // Attack
        //     20 + ((Math.random() * 10) * (Math.random() < 0.4 ? -1.0 : 1.0)),
        //     // Speed
        //     0.04 + ((Math.random() * 0.02) * (Math.random() < 0.4 ? -1.0 : 1.0)),
        //     // Health
        //     100 + ((Math.random() * 50) * (Math.random() < 0.4 ? -1.0 : 1.0)),
        //     // Defense
        //     5 + ((Math.random() * 5) * (Math.random() < 0.4 ? -1.0 : 1.0)),
        //     // Cooldown
        //     0.6 + ((Math.random() * 0.3) * (Math.random() < 0.4 ? -1.0 : 1.0)),
        // ).setOnDie((status) => this.onDie(status));

        // create a record of mapped attributes, so we can use the attributes returned more easily
        // eg: {speed: 20, torso: 'BeetleTorso, name: 'beetle33'}

        const attributesMap: Record<string, any> = {};

        this.details.attributes.map((attribute) => {
            attributesMap[attribute.trait_type] = attribute.value;
        })

        const status = this.self.addStatus(
            // Attack
            20 * (attributesMap["Attack"] / 100.0),
            // Speed
            0.04 * (attributesMap["Speed"] / 100.0),
            // Health
            100,
            // Defense
            5 * (attributesMap["Defence"] / 100.0),
            // Cooldown
            0.5
        );

        status.setOnDie((status) => this.onDie(status));
        status.setOnDamage((damage) => this.onDamage(damage));

        // Add rigibody for current entity
        this.self.addRigidbody(
            grid.intervalX * 1.7,
            grid.intervalY * 1.7,
        );

        this.self.getTransform().setPos(
            spawnPositions.pos[PlayerLayer.playerCount].x,
            spawnPositions.pos[PlayerLayer.playerCount].y
        );

        if (PlayerLayer.playerCount == spawnPositions.pos.length - 1)
            PlayerLayer.playerCount = 0;
        else
            PlayerLayer.playerCount++;

        this.self.addBehavior();

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

        // Updating phase
        const theta = rad2deg(
            Math.atan2(velocity.y, velocity.x)
        );

        if (-45.0 < theta && theta <= 45.0) {
            if (attacking) {
                if (critical) {
                    this.wsClient.broadcast(this.getBaseMsg("update", 10));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", 0));
                }
            } else {
                if (healing) {
                    this.wsClient.broadcast(this.getBaseMsg("update", 24));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", 4));
                }
            }
        } else if (45.0 < theta && theta <= 135.0) {
            if (attacking) {
                if (critical) {
                    this.wsClient.broadcast(this.getBaseMsg("update", 12));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", 2));
                }
            } else {
                if (healing) {
                    this.wsClient.broadcast(this.getBaseMsg("update", 26));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", 6));
                }
            }
        } else if (135.0 < theta && theta <= 180 || theta <= -135.0 && theta >= -180) {
            if (attacking) {
                if (critical) {
                    this.wsClient.broadcast(this.getBaseMsg("update", 11));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", 1));
                }
            } else {
                if (healing) {
                    this.wsClient.broadcast(this.getBaseMsg("update", 25));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", 5));
                }
            }
        } else if (-135.0 < theta && theta <= -45.0) {
            if (attacking) {
                if (critical) {
                    this.wsClient.broadcast(this.getBaseMsg("update", 13));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", 3));
                }
            } else {
                if (healing) {
                    this.wsClient.broadcast(this.getBaseMsg("update", 27));
                } else {
                    this.wsClient.broadcast(this.getBaseMsg("update", 7));
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

        // Destroy the self entity
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
            health: status.health,
            attack: status.attack,
            speed: status.speed,
            defense: status.defense,
            cooldown: status.cooldown,
            maxHealth: status.maxHealth,
            survived: status.survived,
            kills: status.kills,
            char_class: this.self.name.split(' ')[0],
            name: this.self.name
        };
    }

    // When player dies callback
    onDie(status: StatusResult) {
        console.log("Morreu: ", this.name)
        console.log("Resultados: ", status);
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
        }, killerId);
    }

    // When player takes a hit callback
    onDamage(damage: number) {
       this.damageFn(damage, this.strapiID);
    }
}

export { PlayerLayer };
