import { WebSocket } from "ws";
import { WSClient } from "../clients/websocket";
import { GridComponent } from "../core/ecs/components/grid";
import { RigidbodyComponent } from "../core/ecs/components/rigidbody";
import { StatusComponent } from "../core/ecs/components/status";
import { TransformComponent } from "../core/ecs/components/transform";
import { ECS, Entity, Rectangle, Rigidbody, Status, Transform } from "../core/ecs/core/ecs";
import { Layer } from "../core/layer";
import { CollisionResult } from "../utils/collision";
import { Vec2 } from "../utils/math";

//
//  Frontend actions mapping
//  "attackright": 0, "attackleft": 1,
//  "attackup": 2, "attackdown": 3,
//  "walkright": 4, "walkleft": 5,
//  "walkup": 6, "walkdown": 7
//

type OnDieFn = (player: PlayerLayer) => (void);
type GetTargetFn = (player: PlayerLayer) => (Entity | null);

// Fixed spawn points
const spawnPos: Vec2[] = [
    new Vec2( 0.75, 0.0),
    new Vec2( 0.5,  0.3),
    new Vec2( 0.75, 0.7),
    new Vec2(-0.1,  0.53),
    new Vec2( 0.75, 0.3),
    new Vec2( 0.6, -0.4),
    new Vec2(-0.7,  0.6),
    new Vec2(-0.5, -0.4),
    new Vec2(-0.2, -0.6),
    new Vec2( 0.2, -0.6),
];

class PlayerLayer extends Layer {

    private strength: number = 0;
    private attackVel: number = 0;
    private speed: number = 0;

    // Current web socket server client
    private wsClient: WSClient;

    // Player ID
    public playerID: number;

    // Current grid
    private grid: GridComponent;

    // OnDie event fn
    private onDie: OnDieFn = (player) => {};

    // For spawn point selection
    static playerCount: number = 0;

    // For attack purpose
    public hunted: boolean = false;
    private hunting: Entity | null = null;
    private attacking: Entity | null = null;
    private cooldown: number = 0;
    private getTarget: GetTargetFn;
    private hitting: number = 10;

    constructor(ecs: ECS, wsContext: WSClient, id: number, grid: GridComponent, requestTarget: GetTargetFn) {
        super(`Player${id}`, ecs);

        this.wsClient = wsContext;
        this.playerID = id;
        this.grid = grid;
        this.getTarget = requestTarget;

        // Init player's random status
        this.speed = 0.02 + (Math.random() * 0.05);
        this.strength = 20 + ((Math.random() * 50) * (Math.random() < 0.4 ? -1.0 : 1.0));
        this.attackVel = 200 + ((Math.random() * 200) * (Math.random() < 0.4 ? -1.0 : 1.0));

        // Status component
        const status = this.self.addComponent[Status](
            100 + ((Math.random() * 50) * (Math.random() < 0.4 ? -1.0 : 1.0)),
            20 + ((Math.random() * 50) * (Math.random() < 0.4 ? -1.0 : 1.0))
        ) as StatusComponent;

        // On die callback
        status.onSelfDie = () => { 
            this.onDie(this);
            this.self.removeComponent[Status]();
        };

        // Set spawn position
        const tranform = this.self.getComponent[Transform]() as TransformComponent;
        tranform.pos = spawnPos[PlayerLayer.playerCount];

        // Add rectangle and rigidbody component
        this.self.addComponent[Rectangle](grid.intervalX, grid.intervalY);
        const rg = this.self.addComponent[Rigidbody]() as RigidbodyComponent;

        // On collision callback function
        rg.onCollision = (other, result) => this.onCollision(other, result);

        if (PlayerLayer.playerCount < 10)
            PlayerLayer.playerCount++;
    }

    onAttach(): void {
        // Get current pleyr position
        const { pos } = this.self.getComponent[Transform]() as TransformComponent;

        // Create player entity in new client
        this.wsClient.broadcast(
            { type: "create-enemy", content: {id: this.playerID, pos: { x: pos.x, y: pos.y } } }
        );

        this.wsClient.addConListener((ws) => this.onWsConnection(ws))
    }

    onUpdate(deltaTime: number) {

        // Seek the enemy
        if (!this.hunting) {
            this.hunting = this.getTarget(this);
            if (this.hunting) {
                const stats = this.hunting?.getComponent[Status]() as StatusComponent;
                stats.notifyHunter = () => this.onHuntedDead()
            }
        }
        else {
            const enemy = this.hunting.getComponent[Transform]() as TransformComponent;
            const player = this.self.getComponent[Transform]() as TransformComponent;

            const velocity = enemy.pos.sub(player.pos).normalize().muls(this.speed);

            const rg = this.self.getComponent[Rigidbody]() as RigidbodyComponent;
            rg.velocity = velocity;
        }

        // Performs the attack
        if (this.cooldown <= 0) {
            if (this.attacking) {

                const oponent = this.attacking.getComponent[Status]() as StatusComponent;

                if (oponent) {
                    oponent.hit(this.strength);
                    this.hitting = 15;
                }

                this.cooldown = this.attackVel;
            }
        }

        // Reduce cooldown phase
        this.cooldown--;
        this.hitting--;

        // Get current player position
        const { pos } = this.self.getComponent[Transform]() as TransformComponent;

        const rg = this.self.getComponent[Rigidbody]() as RigidbodyComponent;
        const factor = rg.velocity.x / rg.velocity.y;

        if (this.hitting >= 0) {
            if (factor >= 1) {
                if (rg.velocity.x >= 0) {
                    this.wsClient.broadcast(
                        { type: "update-enemy", content: { id: this.playerID, action: 0, pos: { x: pos.x, y: pos.y } } }
                    );
                } else {
                    this.wsClient.broadcast(
                        { type: "update-enemy", content: { id: this.playerID, action: 1, pos: { x: pos.x, y: pos.y } } }
                    );
                }
            } else {
                if (rg.velocity.y >= 0) {
                    this.wsClient.broadcast(
                        { type: "update-enemy", content: { id: this.playerID, action: 2, pos: { x: pos.x, y: pos.y } } }
                    );
                } else {
                    this.wsClient.broadcast(
                        { type: "update-enemy", content: { id: this.playerID, action: 3, pos: { x: pos.x, y: pos.y } } }
                    );
                }
            }
        } else {
            if (factor >= 1) {
                if (rg.velocity.x >= 0) {
                    this.wsClient.broadcast(
                        { type: "update-enemy", content: { id: this.playerID, action: 4, pos: { x: pos.x, y: pos.y } } }
                    );
                } else {
                    this.wsClient.broadcast(
                        { type: "update-enemy", content: { id: this.playerID, action: 5, pos: { x: pos.x, y: pos.y } } }
                    );
                }
            } else {
                if (rg.velocity.y >= 0) {
                    this.wsClient.broadcast(
                        { type: "update-enemy", content: { id: this.playerID, action: 6, pos: { x: pos.x, y: pos.y } } }
                    );
                } else {
                    this.wsClient.broadcast(
                        { type: "update-enemy", content: { id: this.playerID, action: 7, pos: { x: pos.x, y: pos.y } } }
                    );
                }
            }
        }
    }

    onDetach() {
        // Delete player entity in client
        this.wsClient.broadcast(
            { type: "delete-enemy", content: { id: this.playerID } }
        );

        // Removes itself from the grid
        this.grid.removeDynamic(this.self);

        // Destroy the self entity
        this.self.destroy();
    }

    onWsConnection(ws: WebSocket) {
        // Get current pleyr position
        const { pos } = this.self.getComponent[Transform]() as TransformComponent;

        // Create player entity in new client
        ws.send(JSON.stringify(
            { type: "create-enemy", content: {id: this.playerID, pos: { x: pos.x, y: pos.y } } }
        ));

        // Doesn't handle the event
        return false;
    }

    onCollision(other: Entity | null, result: CollisionResult) {
        // If not other, so it's colliding with wall,
        // them try to solve by oposing velocity.
        if (!other) {
            const rg = this.self.getComponent[Rigidbody]() as RigidbodyComponent;

            rg.velocity.x = result.contactNormal.x * this.speed * 2.0;
            rg.velocity.y = result.contactNormal.y * this.speed * 2.0;

            if (result.contactNormal.x == 0) {
                rg.velocity.x *= 1 + Math.random();
            }
            if (result.contactNormal.y == 0) {
                rg.velocity.y *= 1 + Math.random();
            }
        } else {
            this.attacking = other;
        }
    }

    setOnDie(fn: OnDieFn) {
        this.onDie = fn;
    }

    onHuntedDead() {
        this.hunting = null;
    }
}

export { PlayerLayer };