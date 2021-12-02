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
//     new Vec2( 0.40,  0.05), new Vec2( 0.27, -0.40),
//     new Vec2( 0.46,  0.03), new Vec2( 0.27, -0.46),
//     new Vec2( 0.52,  0.02), new Vec2( 0.27, -0.52),
//     new Vec2( 0.58,  0.01), new Vec2( 0.27, -0.58),
//     new Vec2( 0.64,  0.04), new Vec2( 0.27, -0.64),
//     new Vec2( 0.70,  0.02), new Vec2( 0.27, -0.70),
//     new Vec2( 0.76,  0.07), new Vec2( 0.27, -0.76),
//     new Vec2( 0.82,  0.02), new Vec2( 0.27, -0.82),
//     new Vec2( 0.88,  0.01), new Vec2( 0.27, -0.88),
//     new Vec2( 0.40,  0.22), new Vec2(-0.40,  0.00),
//     new Vec2( 0.46,  0.21), new Vec2(-0.46,  0.00),
//     new Vec2( 0.52,  0.22), new Vec2(-0.52,  0.00),
//     new Vec2( 0.58,  0.23), new Vec2(-0.58,  0.00),
//     new Vec2( 0.64,  0.24), new Vec2(-0.64,  0.00),
//     new Vec2( 0.70,  0.20), new Vec2(-0.70,  0.00),
//     new Vec2( 0.76,  0.20), new Vec2(-0.76,  0.00),
//     new Vec2( 0.82,  0.20), new Vec2(-0.82,  0.00),
//     new Vec2( 0.88,  0.20), new Vec2(-0.88,  0.00),
//     new Vec2( 0.40, -0.25), new Vec2(-0.40,  0.20),
//     new Vec2( 0.46, -0.25), new Vec2(-0.46,  0.20),
//     new Vec2( 0.52, -0.25), new Vec2(-0.52,  0.20),
//     new Vec2( 0.58, -0.25), new Vec2(-0.58,  0.20),
//     new Vec2( 0.64, -0.25), new Vec2(-0.64,  0.20),
//     new Vec2( 0.70, -0.25), new Vec2(-0.70,  0.20),
//     new Vec2( 0.76, -0.25), new Vec2(-0.76,  0.20),
//     new Vec2( 0.82, -0.25), new Vec2(-0.82,  0.20),
//     new Vec2( 0.88, -0.25), new Vec2(-0.88,  0.20),
//     new Vec2( 0.00, -0.40), new Vec2(-0.40, -0.20),
//     new Vec2( 0.00, -0.46), new Vec2(-0.46, -0.20),
//     new Vec2( 0.00, -0.52), new Vec2(-0.52, -0.20),
//     new Vec2( 0.00, -0.58), new Vec2(-0.58, -0.20),
//     new Vec2(-0.70, -0.64), new Vec2(-0.64, -0.20),
//     new Vec2(-0.60, -0.70), new Vec2(-0.70, -0.20),
//     new Vec2(-0.50, -0.76), new Vec2(-0.76, -0.20),
//     new Vec2(-0.40, -0.82), new Vec2(-0.82, -0.20),
//     new Vec2(-0.30, -0.88), new Vec2(-0.88, -0.20),
//     new Vec2(-0.27, -0.40), new Vec2( 0.00,  0.40),
//     new Vec2(-0.27, -0.46), new Vec2( 0.00,  0.46),
//     new Vec2(-0.27, -0.52), new Vec2( 0.00,  0.52),
//     new Vec2(-0.27, -0.58), new Vec2( 0.00,  0.58),
//     new Vec2(-0.27, -0.64), new Vec2( 0.50,  0.64),
//     new Vec2(-0.27, -0.70), new Vec2( 0.40,  0.70),
//     new Vec2(-0.27, -0.76), new Vec2( 0.30,  0.76),
//     new Vec2(-0.27, -0.82), new Vec2(-0.20,  0.40),
//     new Vec2(-0.27, -0.88), new Vec2(-0.20,  0.46),
//     new Vec2(-0.20,  0.52), new Vec2( 0.20,  0.52),
//     new Vec2(-0.20,  0.58), new Vec2( 0.20,  0.58),
//     new Vec2(-0.20,  0.64), new Vec2( 0.20,  0.64),
//     new Vec2(-0.20,  0.70), new Vec2( 0.20,  0.70),
//     new Vec2(-0.20,  0.76), new Vec2( 0.20,  0.76),
// ];
const spawnPos = [
    new Vec2(-0.37, 0.03536208589496281),
    new Vec2(-0.408, -0.02304629020382781),
    new Vec2(-0.446, -0.020781127092536163),
    new Vec2(-0.484, -0.02973688240461509),
    new Vec2(-0.522, 0.030171856895564123),
    new Vec2(-0.56, 0.03064529255357592),
    new Vec2(-0.598, -0.029229816860608),
    new Vec2(-0.636, -0.020736565843974222),
    new Vec2(-0.6739999999999999, -0.030153500289247428),
    new Vec2(-0.712, 0.0375398152985812),
    new Vec2(-0.75, 0.034404774123597374),
    new Vec2(-0.788, -0.024138648499660475),
    new Vec2(-0.826, -0.00016430868347075279),

    new Vec2(-0.37, 0.12078864477616073),
    new Vec2(-0.408, 0.10840330394039345),
    new Vec2(-0.446, 0.13928682655869631),
    new Vec2(-0.484, 0.10909489095938614),
    new Vec2(-0.522, 0.07725616649131185),
    new Vec2(-0.56, 0.14430271794078323),
    new Vec2(-0.598, 0.10551038627333924),
    new Vec2(-0.636, 0.11411120017449049),
    new Vec2(-0.6739999999999999, 0.10829703151681955),
    new Vec2(-0.712, 0.12207470440517848),
    new Vec2(-0.75, 0.10758649699151913),
    new Vec2(-0.788, 0.07618018927512332),
    new Vec2(-0.826, 0.11697625356978249),

    new Vec2(-0.37, -0.09991360985427374),
    new Vec2(-0.408, -0.10731658007791227),
    new Vec2(-0.446, -0.09898264109715436),
    new Vec2(-0.484, -0.1042507432229265),
    new Vec2(-0.522, -0.13945325735737638),
    new Vec2(-0.56, -0.08506566949321084),
    new Vec2(-0.598, -0.08032222928148475),
    new Vec2(-0.636, -0.09949343279086115),
    new Vec2(-0.6739999999999999, -0.13713618663750793),
    new Vec2(-0.712, -0.1431602424486858),
    new Vec2(-0.75, -0.11421627087558828),
    new Vec2(-0.788, -0.09212112144118073),
    new Vec2(-0.826, -0.13831477381442323),

    new Vec2(0.37, 0.03536208589496281),
    new Vec2(0.408, -0.02304629020382781),
    new Vec2(0.446, -0.020781127092536163),
    new Vec2(0.484, -0.02973688240461509),
    new Vec2(0.522, 0.030171856895564123),
    new Vec2(0.56, 0.03064529255357592),
    new Vec2(0.598, -0.029229816860608),
    new Vec2(0.636, -0.020736565843974222),
    new Vec2(0.6739999999999999, -0.030153500289247428),
    new Vec2(0.712, 0.0375398152985812),
    new Vec2(0.75, 0.034404774123597374),
    new Vec2(0.788, -0.024138648499660475),
    new Vec2(0.826, -0.00016430868347075279),

    new Vec2(0.37, 0.12078864477616073),
    new Vec2(0.408, 0.10840330394039345),
    new Vec2(0.446, 0.13928682655869631),
    new Vec2(0.484, 0.10909489095938614),
    new Vec2(0.522, 0.07725616649131185),
    new Vec2(0.56, 0.14430271794078323),
    new Vec2(0.598, 0.10551038627333924),
    new Vec2(0.636, 0.11411120017449049),
    new Vec2(0.6739999999999999, 0.10829703151681955),
    new Vec2(0.712, 0.12207470440517848),
    new Vec2(0.75, 0.10758649699151913),
    new Vec2(0.788, 0.07618018927512332),
    new Vec2(0.826, 0.11697625356978249),

    new Vec2(0.37, -0.09991360985427374),
    new Vec2(0.408, -0.10731658007791227),
    new Vec2(0.446, -0.09898264109715436),
    new Vec2(0.484, -0.1042507432229265),
    new Vec2(0.522, -0.13945325735737638),
    new Vec2(0.56, -0.08506566949321084),
    new Vec2(0.598, -0.08032222928148475),
    new Vec2(0.636, -0.09949343279086115),
    new Vec2(0.6739999999999999, -0.13713618663750793),
    new Vec2(0.712, -0.1431602424486858),
    new Vec2(0.75, -0.11421627087558828),
    new Vec2(0.788, -0.09212112144118073),
    new Vec2(0.826, -0.13831477381442323),

    new Vec2(-0.38, 0.24895691675467546),
    new Vec2(-0.342, 0.2826522253710198),
    new Vec2(-0.304, 0.31062040176403505),
    new Vec2(-0.266, 0.25574239919775393),
    new Vec2(-0.228, 0.25992863054973075),
    new Vec2(-0.19, 0.30368241130416584),
    new Vec2(-0.15200000000000002, 0.31260641442962417),
    new Vec2(-0.11399999999999999, 0.24770906450564223),
    new Vec2(-0.07600000000000001, 0.2745888669405554),
    new Vec2(-0.038000000000000034, 0.259478036835217),
    new Vec2(0.0, 0.2860624701352102),
    new Vec2(0.03799999999999998, 0.2593189366560935),
    new Vec2(0.07599999999999996, 0.2669448154137115),
    new Vec2(0.11399999999999999, 0.30971643608824756),
    new Vec2(0.15200000000000002, 0.30116344514637344),
    new Vec2(0.18999999999999995, 0.2828380333398697),
    new Vec2(0.22799999999999998, 0.2727057309376484),
    new Vec2(0.266, 0.2532197531997578),
    new Vec2(0.30399999999999994, 0.30642573428974884),
    new Vec2(0.34199999999999997, 0.31079567030380884),

    new Vec2(-0.3801, -0.2504157807535029),
    new Vec2(-0.342, -0.2553029178128466),
    new Vec2(-0.304, -0.2745157091018446),
    new Vec2(-0.266, -0.2459951234226099),
    new Vec2(-0.228, -0.26435926654285885),
    new Vec2(-0.19, -0.2952006797632489),
    new Vec2(-0.15200000000000002, -0.2908697058527241),
    new Vec2(-0.11399999999999999, -0.2814445930926542),
    new Vec2(-0.07600000000000001, -0.2664147252862474),
    new Vec2(-0.038000000000000034, -0.2696400239070358),
    new Vec2(0.0, -0.26972497307676124),
    new Vec2(0.03799999999999998, -0.2709158160339348),
    new Vec2(0.07599999999999996, -0.28053369064436645),
    new Vec2(0.11399999999999999, -0.26898671282575554),
    new Vec2(0.15200000000000002, -0.27918041346532535),
    new Vec2(0.18999999999999995, -0.24750182199796766),
    new Vec2(0.22799999999999998, -0.27795369343621373),
    new Vec2(0.266, -0.2516742027057217),
    new Vec2(0.30399999999999994, -0.28155235168356146),
    new Vec2(0.34199999999999997, -0.3077348680627433),
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

        const get_rate = () => {
            return Math.random() * 80 + 20;
            // return Math.random() * 0.8 + 0.2;
        }
        
        // Add status component to current entity
        this.self.addStatus(
            // Attack
            get_rate(),
            // 20 * get_rate(),
            // Speed
            get_rate() / 500,
            // 0.05 * get_rate(),
            // Health
            100,
            // 150,
            // Defense
            get_rate(),
            // 15 * get_rate(),
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

        console.log("Passou 1")

        this.wsClient.broadcast({
            killed: this.self.name,
            killer: killer,
            action: killFeed.items[killFeed.items.length * Math.random() | 0],
            msgType: "kill"
        });

        console.log("Passou 2")

        this.dieFn({
            scheduled_game_participant: this.strapiID,
            survived_for: Math.floor(status.survived),
            kills: Math.floor(status.kills),
            health: Math.floor(status.health),
        });

        console.log("Passou 3")
    }
}

export { PlayerLayer };