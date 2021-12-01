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

//
//  Frontend actions mapping
//  "attackright": 0, "attackleft": 1,
//  "attackup": 2, "attackdown": 3,
//  "walkright": 4, "walkleft": 5,
//  "walkup": 6, "walkdown": 7
//

// const spawnPos = [
//     new Vec2( 0.65,  0.00), new Vec2(-0.65,  0.00),
//     new Vec2( 0.00,  0.60), new Vec2( 0.00, -0.60),
//     new Vec2( 0.40,  0.20), new Vec2(-0.40, -0.25),
//     new Vec2(-0.40,  0.20), new Vec2( 0.40, -0.25),
//     new Vec2( 0.90,  0.20), new Vec2(-0.90,  0.20),
//     new Vec2( 0.90, -0.25), new Vec2(-0.90, -0.25),
//     new Vec2(-0.30, -0.90), new Vec2( 0.30,  0.80),
//     new Vec2(-0.30,  0.80), new Vec2( 0.30, -0.90),
//     new Vec2( 0.90,  0.00), new Vec2(-0.90,  0.00),
//     new Vec2( 0.00,  0.80), new Vec2( 0.00, -0.90),
//     new Vec2( 0.65,  0.24), new Vec2(-0.65,  0.24),
//     new Vec2(-0.32,  0.63), new Vec2( 0.32, -0.65),
//     new Vec2(-0.32, -0.65), new Vec2( 0.32,  0.63),
//     new Vec2( 0.65, -0.28), new Vec2(-0.65, -0.28),
// ];

const spawnPos = [
    new Vec2( 0.40,  0.05), new Vec2( 0.27, -0.40),
    new Vec2( 0.46,  0.03), new Vec2( 0.27, -0.46),
    new Vec2( 0.52,  0.02), new Vec2( 0.27, -0.52),
    new Vec2( 0.58,  0.01), new Vec2( 0.27, -0.58),
    new Vec2( 0.64,  0.04), new Vec2( 0.27, -0.64),
    new Vec2( 0.70,  0.02), new Vec2( 0.27, -0.70),
    new Vec2( 0.76,  0.07), new Vec2( 0.27, -0.76),
    new Vec2( 0.82,  0.02), new Vec2( 0.27, -0.82),
    new Vec2( 0.88,  0.01), new Vec2( 0.27, -0.88),
    new Vec2( 0.40,  0.22), new Vec2(-0.40,  0.00),
    new Vec2( 0.46,  0.21), new Vec2(-0.46,  0.00),
    new Vec2( 0.52,  0.22), new Vec2(-0.52,  0.00),
    new Vec2( 0.58,  0.23), new Vec2(-0.58,  0.00),
    new Vec2( 0.64,  0.24), new Vec2(-0.64,  0.00),
    new Vec2( 0.70,  0.20), new Vec2(-0.70,  0.00),
    new Vec2( 0.76,  0.20), new Vec2(-0.76,  0.00),
    new Vec2( 0.82,  0.20), new Vec2(-0.82,  0.00),
    new Vec2( 0.88,  0.20), new Vec2(-0.88,  0.00),
    new Vec2( 0.40, -0.25), new Vec2(-0.40,  0.20),
    new Vec2( 0.46, -0.25), new Vec2(-0.46,  0.20),
    new Vec2( 0.52, -0.25), new Vec2(-0.52,  0.20),
    new Vec2( 0.58, -0.25), new Vec2(-0.58,  0.20),
    new Vec2( 0.64, -0.25), new Vec2(-0.64,  0.20),
    new Vec2( 0.70, -0.25), new Vec2(-0.70,  0.20),
    new Vec2( 0.76, -0.25), new Vec2(-0.76,  0.20),
    new Vec2( 0.82, -0.25), new Vec2(-0.82,  0.20),
    new Vec2( 0.88, -0.25), new Vec2(-0.88,  0.20),
    new Vec2( 0.00, -0.40), new Vec2(-0.40, -0.20),
    new Vec2( 0.00, -0.46), new Vec2(-0.46, -0.20),
    new Vec2( 0.00, -0.52), new Vec2(-0.52, -0.20),
    new Vec2( 0.00, -0.58), new Vec2(-0.58, -0.20),
    new Vec2( 0.00, -0.64), new Vec2(-0.64, -0.20),
    new Vec2( 0.00, -0.70), new Vec2(-0.70, -0.20),
    new Vec2( 0.00, -0.76), new Vec2(-0.76, -0.20),
    new Vec2( 0.00, -0.82), new Vec2(-0.82, -0.20),
    new Vec2( 0.00, -0.88), new Vec2(-0.88, -0.20),
    new Vec2(-0.27, -0.40), new Vec2( 0.00,  0.40),
    new Vec2(-0.27, -0.46), new Vec2( 0.00,  0.46),
    new Vec2(-0.27, -0.52), new Vec2( 0.00,  0.52),
    new Vec2(-0.27, -0.58), new Vec2( 0.00,  0.58),
    new Vec2(-0.27, -0.64), new Vec2( 0.00,  0.64),
    new Vec2(-0.27, -0.70), new Vec2( 0.00,  0.70),
    new Vec2(-0.27, -0.76), new Vec2( 0.00,  0.76),
    new Vec2(-0.27, -0.82), new Vec2(-0.20,  0.40),
    new Vec2(-0.27, -0.88), new Vec2(-0.20,  0.46),
    new Vec2(-0.20,  0.52), new Vec2( 0.20,  0.52),
    new Vec2(-0.20,  0.58), new Vec2( 0.20,  0.58),
    new Vec2(-0.20,  0.64), new Vec2( 0.20,  0.64),
    new Vec2(-0.20,  0.70), new Vec2( 0.20,  0.70),
    new Vec2(-0.20,  0.76), new Vec2( 0.20,  0.76),
];

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
    public dieFn: (result: GameParticipantsResult) => void;

    constructor(ecs: ECS, 
                wsContext: WSClient, 
                id: string, 
                strapiID: number, 
                grid: Grid, 
                dieFn: (result: GameParticipantsResult) => void, 
                details: ParticipantDetails ) {
        
        super(`Player${id}`, ecs);

        this.wsClient = wsContext;
        this.playerID = id;
        this.grid = grid;
        this.dieFn = dieFn;
        this.self.name = details.name;
        this.strapiID = strapiID;
        this.details = details;

        // Add status component to current entity
        this.self.addStatus(
            // Attack
            20 + ((Math.random() * 10) * (Math.random() < 0.4 ? -1.0 : 1.0)),
            // Speed
            0.04 + ((Math.random() * 0.02) * (Math.random() < 0.4 ? -1.0 : 1.0)),
            // Health
            100 + ((Math.random() * 50) * (Math.random() < 0.4 ? -1.0 : 1.0)),
            // Defense
            5 + ((Math.random() * 5) * (Math.random() < 0.4 ? -1.0 : 1.0)),
            // Cooldown
            0.6 + ((Math.random() * 0.3) * (Math.random() < 0.4 ? -1.0 : 1.0)),
        ).setOnDie((status) => this.onDie(status));

        // create a record of mapped attributes, so we can use the attributes returned more easily
        // eg: {speed: 20, torso: 'BeetleTorso, name: 'beetle33'}
        
        const attributesMap: Record<string, any> = {};

        // this.details.attributes.map((attribute) => {
        //     attributesMap[attribute.trait_type] = attribute.value;
        // })
 
        // this.self.addStatus(
        //     // Attack
        //     attributesMap["Attack"],
        //     // Speed
        //     attributesMap["Speed"] / 500,
        //     // Health
        //     attributesMap["Health"],
        //     // Defense
        //     attributesMap["Defence"],
        //     // Cooldown
        //     0.6 + ((Math.random() * 0.3) * (Math.random() < 0.4 ? -1.0 : 1.0)),
        // ).setOnDie((status) => this.onDie(status));

        // Add rigibody for current entity
        this.self.addRigidbody(
            grid.intervalX * 1.7,
            grid.intervalY * 1.7,
        );

        this.self.getTransform().setPos(
            spawnPos[PlayerLayer.playerCount].x, 
            spawnPos[PlayerLayer.playerCount].y
        );

        if (PlayerLayer.playerCount == 99)
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
        };
    }

    // When player dies callback
    onDie(status: StatusResult) {
        console.log("Morreu: ", this.name)
        console.log("Resultados: ", status);
        const killer = this.self.getStatus().lastHit.name;

        this.wsClient.broadcast({
            killed: this.self.name,
            killer: killer,
            action: killFeed.items[killFeed.items.length * Math.random() | 0],
            msgType: "kill"
        });

        this.dieFn({
            scheduled_game_participant: this.strapiID,
            survived_for: Math.floor(status.survived),
            kills: Math.floor(status.kills),
            health: Math.floor(status.health),
        });
    }
}

export { PlayerLayer };