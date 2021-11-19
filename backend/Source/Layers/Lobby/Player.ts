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
    new Vec2( 0.65,  0.00), new Vec2( 0.90, -0.00),
    new Vec2( 0.00,  0.60), new Vec2( 0.00, -0.60),
    new Vec2( 0.40,  0.20), new Vec2(-0.40, -0.25),
    new Vec2(-0.40,  0.20), new Vec2( 0.40, -0.25),
    new Vec2( 0.90,  0.20), new Vec2(-0.90,  0.20),
    new Vec2( 0.90, -0.25), new Vec2(-0.90, -0.25),
    new Vec2(-0.30, -0.90), new Vec2( 0.30,  0.80),
    new Vec2(-0.30,  0.80), new Vec2( 0.30, -0.90),
    new Vec2( 0.90,  0.00), new Vec2(-0.90,  0.00),
    new Vec2( 0.00,  0.80), new Vec2( 0.00, -0.90),
    new Vec2( 0.65,  0.24), new Vec2(-0.65,  0.24),
    new Vec2(-0.32,  0.63), new Vec2( 0.32, -0.65),
    new Vec2(-0.32, -0.65), new Vec2( 0.32,  0.63),
    new Vec2( 0.65, -0.28), new Vec2(-0.65, -0.28),
];

class PlayerLayer extends Layer {

    // Current web socket server client
    private wsClient: WSClient;
    private conListener: OnConnectionListener;

    // Player ID
    public playerID: string;

    // Current grid
    private grid: Grid;

    // For spawn point selection
    static playerCount: number = 0;

    // Die fn
    public dieFn: () => void;

    constructor(ecs: ECS, wsContext: WSClient, id: string, grid: Grid, dieFn: () => void) {
        super(`Player${id}`, ecs);

        this.wsClient = wsContext;
        this.playerID = id;
        this.grid = grid;
        this.dieFn = dieFn;

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

        // Add rigibody for current entity
        this.self.addRigidbody(
            grid.intervalX * 1.7,
            grid.intervalY * 1.7,
        );

        this.self.getTransform().setPos(
            spawnPos[PlayerLayer.playerCount].x, 
            spawnPos[PlayerLayer.playerCount].y
        );

        if (PlayerLayer.playerCount <= 28)
            PlayerLayer.playerCount++;
        else
            PlayerLayer.playerCount = 0;

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
        const { attacking } = this.self.getBehavior();
        const { velocity } = this.self.getRigidbody();
        
        // Updating phase
        const theta = rad2deg(
            Math.atan2(velocity.y, velocity.x)
        );

        if (-45.0 < theta && theta <= 45.0) {
            if (attacking) {
                this.wsClient.broadcast(this.getBaseMsg("update", 0));
            } else {
                this.wsClient.broadcast(this.getBaseMsg("update", 4));
            }
        } else if (45.0 < theta && theta <= 135.0) {
            if (attacking) {
                this.wsClient.broadcast(this.getBaseMsg("update", 2));
            } else {
                this.wsClient.broadcast(this.getBaseMsg("update", 6));
            }
        } else if (135.0 < theta && theta <= 180 || theta <= -135.0 && theta >= -180) {
            if (attacking) {
                this.wsClient.broadcast(this.getBaseMsg("update", 1));
            } else {
                this.wsClient.broadcast(this.getBaseMsg("update", 5));
            }
        } else if (-135.0 < theta && theta <= -45.0) {
            if (attacking) {
                this.wsClient.broadcast(this.getBaseMsg("update", 3));
            } else {
                this.wsClient.broadcast(this.getBaseMsg("update", 7));
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
        // this.self.getStatus().lastHit;

        // this.wsClient.broadcast({
        //     killed: this.getName();
        //     killer: 
        // });

        this.dieFn();
    }
}

export { PlayerLayer };