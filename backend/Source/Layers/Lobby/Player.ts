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

const spawnPos = [
    // new Vec2(-0.201, -0.3),
    // new Vec2(-0.704, 0.4),
    // new Vec2(-0.201, 0.21),
    // new Vec2(0.176, -0.3),
    // new Vec2(0.176, 0.21),
    // new Vec2(0.380, 0.0),
    // new Vec2(-0.118, -0.3),
    // new Vec2(-0.118, 0.21),
    // new Vec2(0.380, -0.09),
    // new Vec2(0.758, 0.0),
    // new Vec2(0.380, -0.15),
    // new Vec2(0.758, 0.09),
    // new Vec2(0.758, -0.09),
    // new Vec2(0.758, -0.15),
    // new Vec2(-0.286, -0.3),
    // new Vec2(0.050, -0.3),
    // new Vec2(0.788, 0.4),
    // new Vec2(0.050, 0.21),
    // new Vec2(-0.284, -0.5),
    // new Vec2(-0.368, -0.5),
    // new Vec2(-0.368, 0.4),
    // new Vec2(0.368, -0.5),
    // new Vec2(0.134, 0.21),
    // new Vec2(0.368, 0.4),
    // new Vec2(-0.830, -0.5),
    // new Vec2(-0.830, 0.4),
    // new Vec2(0.830, -0.5),
    // new Vec2(0.830, 0.4),
    // new Vec2(0.218, -0.3),
    // new Vec2(0.218, 0.21),
    // new Vec2(-0.244, -0.3),
    // new Vec2(-0.244, 0.21),
    // new Vec2(0.674, 0.0),
    // new Vec2(0.674, 0.09),
    // new Vec2(0.674, -0.09),
    // new Vec2(0.674, -0.15),
    // new Vec2(-0.159, -0.3),
    // new Vec2(-0.159, 0.21),
    // new Vec2(-0.326, -0.5),
    // new Vec2(-0.326, 0.4),
    // new Vec2(0.326, -0.5),
    // new Vec2(0.326, 0.4),
    // new Vec2(-0.704, -0.5),
    // new Vec2(0.788, -0.5),
    // new Vec2(0.704, -0.5),
    // new Vec2(0.704, 0.4),
    // new Vec2(-0.284, 0.4),
    // new Vec2(0.380, 0.09),
    // new Vec2(0.284, 0.4),
    // new Vec2(0.452, -0.5),
    // new Vec2(-0.788, -0.5),
    // new Vec2(-0.788, 0.4),
    // new Vec2(-0.620, 0.4),
    // new Vec2(0.134, -0.3),
    // new Vec2(0.620, 0.4),
    // new Vec2(0.260, 0.21),
    // new Vec2(0.284, -0.5),
    // new Vec2(0.452, 0.4),
    // new Vec2(-0.452, -0.5),
    // new Vec2(-0.286, 0.21),
    // new Vec2(0.260, -0.3),
    // new Vec2(0.344, -0.3),
    // new Vec2(-0.620, -0.5),
    // new Vec2(0.620, -0.5),
    // new Vec2(-0.884, -0.15),
    // new Vec2(-0.452, 0.4),
    // new Vec2(0.344, 0.21),
    // new Vec2(0.590, 0.0),
    // new Vec2(0.590, -0.15),
    // new Vec2(0.242, -0.5),
    // new Vec2(-0.884, 0.09),
    // new Vec2(-0.242, 0.4),
    // new Vec2(-0.242, -0.5),
    // new Vec2(0.092, -0.3),
    // new Vec2(-0.884, 0.0),
    // new Vec2(-0.884, -0.09),
    // new Vec2(0.590, -0.09),
    // new Vec2(0.008, 0.21),
    // new Vec2(0.242, 0.4),
    // new Vec2(0.092, 0.21),
    // new Vec2(0.506, 0.0),
    // new Vec2(0.008, -0.3),
    // new Vec2(-0.422, -0.15),
    // new Vec2(0.506, -0.09),
    // new Vec2(-0.422, -0.09),
    // new Vec2(0.590, 0.09),
    // new Vec2(0.302, 0.21),
    // new Vec2(0.506, -0.15),
    // new Vec2(-0.422, 0.0),
    // new Vec2(-0.422, 0.09),
    // new Vec2(-0.548, -0.09),
    // new Vec2(0.506, 0.09),
    // new Vec2(-0.075, 0.21),
    // new Vec2(-0.548, 0.0),
    // new Vec2(0.302, -0.3),
    // new Vec2(0.548, -0.09),
    // new Vec2(-0.548, -0.15),
    // new Vec2(0.548, 0.0),
    // new Vec2(0.548, 0.09),
    // new Vec2(0.536, -0.5),
    // new Vec2(-0.548, 0.09),
    // new Vec2(-0.494, -0.5),
    // new Vec2(-0.075, -0.3),
    // new Vec2(-0.536, -0.5),
    // new Vec2(-0.758, -0.15),
    // new Vec2(-0.536, 0.4),
    // new Vec2(0.548, -0.15),
    // new Vec2(0.536, 0.4),
    // new Vec2(-0.758, 0.09),
    // new Vec2(0.494, 0.4),
    // new Vec2(-0.758, -0.09),
    // new Vec2(-0.494, 0.4),
    // new Vec2(-0.716, 0.09),
    // new Vec2(-0.758, 0.0),
    // new Vec2(-0.716, 0.0),
    // new Vec2(0.494, -0.5),
    // new Vec2(-0.200, 0.4),
    // new Vec2(0.632, 0.0),
    // new Vec2(0.200, 0.4),
    // new Vec2(-0.716, -0.09),
    // new Vec2(-0.200, -0.5),
    // new Vec2(0.632, -0.15),
    // new Vec2(-0.842, -0.09),
    // new Vec2(-0.590, 0.0),
    // new Vec2(-0.716, -0.15),
    // new Vec2(-0.590, -0.15),
    // new Vec2(0.632, -0.09),
    // new Vec2(0.200, -0.5),
    // new Vec2(-0.590, 0.09),
    // new Vec2(-0.590, -0.09),
    // new Vec2(-0.578, -0.5),
    // new Vec2(0.632, 0.09),
    // new Vec2(-0.842, 0.09),
    // new Vec2(-0.842, 0.0),
    // new Vec2(-0.410, -0.5),
    // new Vec2(-0.842, -0.15),
    // new Vec2(-0.578, 0.4),
    // new Vec2(-0.380, 0.09),
    // new Vec2(0.578, -0.5),
    // new Vec2(-0.380, 0.0),
    // new Vec2(0.410, -0.5),
    // new Vec2(-0.380, -0.09),
    // new Vec2(-0.674, 0.0),
    // new Vec2(0.410, 0.4),
    // new Vec2(-0.410, 0.4),
    // new Vec2(0.578, 0.4),
    // new Vec2(-0.632, -0.09),
    // new Vec2(0.884, -0.15),
    // new Vec2(0.662, -0.5),
    // new Vec2(-0.380, -0.15),
    // new Vec2(-0.632, 0.09),
    // new Vec2(0.464, 0.09),
    // new Vec2(-0.632, -0.15),
    // new Vec2(-0.662, 0.4),
    // new Vec2(-0.632, 0.0),
    // new Vec2(-0.674, -0.15),
    // new Vec2(0.464, 0.0),
    // new Vec2(-0.662, -0.5),
    // new Vec2(0.464, -0.09),
    // new Vec2(-0.674, 0.09),
    // new Vec2(-0.674, -0.09),
    // new Vec2(0.842, 0.09),
    // new Vec2(0.746, -0.5),
    // new Vec2(0.884, 0.09),
    // new Vec2(-0.033, -0.3),
    // new Vec2(0.662, 0.4),
    // new Vec2(-0.926, -0.09),
    // new Vec2(0.716, -0.09),
    // new Vec2(-0.033, 0.21),
    // new Vec2(0.800, 0.09),
    // new Vec2(0.464, -0.15),
    // new Vec2(0.884, 0.0),
    // new Vec2(0.842, -0.09),
    // new Vec2(0.422, 0.0),
    // new Vec2(0.716, 0.09),
    // new Vec2(0.884, -0.09),
    // new Vec2(0.716, 0.0),
    // new Vec2(-0.746, -0.5),
    // new Vec2(0.800, -0.15),
    // new Vec2(0.842, 0.0),
    // new Vec2(0.926, 0.0),
    // new Vec2(0.842, -0.15),
    // new Vec2(0.716, -0.15),
    // new Vec2(0.422, 0.09),
    // new Vec2(0.800, 0.0),
    // new Vec2(0.746, 0.4),
    // new Vec2(-0.746, 0.4),
    // new Vec2(0.800, -0.09),
    // new Vec2(-0.926, 0.0),
    // new Vec2(-0.926, -0.15),
    // new Vec2(0.422, -0.09),
    // new Vec2(-0.506, 0.0),
    // new Vec2(0.926, -0.09),
    // new Vec2(0.422, -0.15),
    // new Vec2(0.926, -0.15),
    // new Vec2(0.926, 0.09),
    // new Vec2(-0.926, 0.09),
    // new Vec2(-0.464, 0.09),
    // new Vec2(-0.464, 0.0),
    // new Vec2(-0.464, -0.15),
    // new Vec2(-0.506, 0.09),
    // new Vec2(-0.506, -0.15),
    // new Vec2(-0.464, -0.09),
    // new Vec2(-0.800, -0.15),
    // new Vec2(-0.506, -0.09),
    // new Vec2(-0.800, 0.0),
    // new Vec2(-0.800, 0.09),
    // new Vec2(-0.800, -0.09),

    new Vec2(-0.2843,-0.2152),
    new Vec2(-0.6308,0.4016),
    new Vec2(-0.1251,0.2549),
    new Vec2(0.2146,-0.3022),
    new Vec2(0.1891,0.3437),
    new Vec2(0.2855,0.0319),
    new Vec2(-0.0939,-0.3188),
    new Vec2(-0.0749,0.2390),
    new Vec2(0.4724,-0.0612),
    new Vec2(0.9286,0.0172),
    new Vec2(0.3185,-0.1155),
    new Vec2(0.7811,0.2096),
    new Vec2(0.7400,-0.0542),
    new Vec2(0.6951,-0.1424),
    new Vec2(-0.3227,-0.1403),
    new Vec2(0.0163,-0.2735),
    new Vec2(0.7416,0.3018),
    new Vec2(0.2873,0.2050),
    new Vec2(-0.2356,-0.4840),
    new Vec2(-0.3930,-0.4679),
    new Vec2(-0.4198,0.3717),
    new Vec2(0.4773,-0.4822),
    new Vec2(0.1844,0.1698),
    new Vec2(0.3957,0.3871),
    new Vec2(-0.7920,-0.4645),
    new Vec2(-0.6737,0.4164),
    new Vec2(0.8609,-0.4457),
    new Vec2(0.7720,0.3792),
    new Vec2(0.2504,-0.2652),
    new Vec2(0.3657,0.1945),
    new Vec2(-0.2562,-0.3029),
    new Vec2(-0.2925,0.3304),
    new Vec2(0.6385,0.0345),
    new Vec2(0.7527,0.1047),
    new Vec2(0.5572,0.0023),
    new Vec2(0.6858,-0.0787),
    new Vec2(-0.2023,-0.2475),
    new Vec2(-0.1861,0.2421),
    new Vec2(-0.1933,-0.4041),
    new Vec2(-0.2835,0.3597),
    new Vec2(0.2757,-0.4990),
    new Vec2(0.4211,0.4164),
    new Vec2(-0.7635,-0.3792),
    new Vec2(0.7890,-0.5079),
    new Vec2(0.6740,-0.4042),
    new Vec2(0.6850,0.2410),
    new Vec2(-0.2493,0.3831),
    new Vec2(0.3190,0.0612),
    new Vec2(0.2965,0.4030),
    new Vec2(0.5408,-0.4063),
    new Vec2(-0.7251,-0.4617),
    new Vec2(-0.7628,0.3153),
    new Vec2(-0.5455,0.4056),
    new Vec2(0.1090,-0.3283),
    new Vec2(0.7289,0.3325),
    new Vec2(0.1154,0.2577),
    new Vec2(0.3669,-0.4568),
    new Vec2(0.4372,0.3441),
    new Vec2(-0.5292,-0.4839),
    new Vec2(-0.3647,0.2623),
    new Vec2(0.2979,-0.1884),
    new Vec2(0.3327,-0.4150),
    new Vec2(-0.7353,-0.5096),
    new Vec2(0.6909,-0.3490),
    new Vec2(-0.9083,0.0177),
    new Vec2(-0.4665,0.2587),
    new Vec2(0.4282,0.2338),
    new Vec2(0.6092,0.0562),
    new Vec2(0.5782,-0.1750),
    new Vec2(0.2903,-0.4129),
    new Vec2(-0.6114,-0.0001),
    new Vec2(-0.2976,0.3984),
    new Vec2(-0.1311,-0.4295),
    new Vec2(0.1756,-0.2388),
    new Vec2(-0.9106,0.0581),
    new Vec2(-0.8395,-0.1112),
    new Vec2(0.6393,-0.0431),
    new Vec2(0.0238,0.2014),
    new Vec2(0.1297,0.4145),
    new Vec2(0.0841,0.1799),
    new Vec2(0.6586,0.0768),
    new Vec2(0.0384,-0.2388),
    new Vec2(-0.4812,-0.1046),
    new Vec2(0.5243,-0.0023),
    new Vec2(-0.3702,-0.1402),
    new Vec2(0.5919,0.1314),
    new Vec2(0.3395,0.2238),
    new Vec2(0.4960,-0.1310),
    new Vec2(-0.4946,0.0016),
    new Vec2(-0.3989,0.1697),
    new Vec2(-0.6186,-0.0687),
    new Vec2(0.5430,0.1741),
    new Vec2(-0.1181,0.3941),
    new Vec2(-0.5395,0.0034),
    new Vec2(0.4076,-0.2775),
    new Vec2(0.5827,-0.0828),
    new Vec2(-0.5561,-0.1301),
    new Vec2(0.5711,-0.1236),
    new Vec2(0.6848,0.0225),
    new Vec2(0.6867,-0.5198),
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
            spawnPos[PlayerLayer.playerCount].x,
            spawnPos[PlayerLayer.playerCount].y
        );

        if (PlayerLayer.playerCount == spawnPos.length - 1)
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

export { PlayerLayer, spawnPos };
