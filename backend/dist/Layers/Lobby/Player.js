"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.PlayerLayer = void 0;
var Layer_1 = require("../../Core/Layer");
var Math_1 = require("../../Utils/Math");
// Kill feed actions
var KillFeed_json_1 = __importDefault(require("../../Assets/KillFeed.json"));
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
var spawnPos = [
    new Math_1.Vec2(0.65, 0.00), new Math_1.Vec2(0.90, -0.00),
    new Math_1.Vec2(0.00, 0.60), new Math_1.Vec2(0.00, -0.60),
    new Math_1.Vec2(0.40, 0.20), new Math_1.Vec2(-0.40, -0.25),
    new Math_1.Vec2(-0.40, 0.20), new Math_1.Vec2(0.40, -0.25),
    new Math_1.Vec2(0.90, 0.20), new Math_1.Vec2(-0.90, 0.20),
    new Math_1.Vec2(0.90, -0.25), new Math_1.Vec2(-0.90, -0.25),
    new Math_1.Vec2(-0.30, -0.90), new Math_1.Vec2(0.30, 0.80),
    new Math_1.Vec2(-0.30, 0.80), new Math_1.Vec2(0.30, -0.90),
    new Math_1.Vec2(0.90, 0.00), new Math_1.Vec2(-0.90, 0.00),
    new Math_1.Vec2(0.00, 0.80), new Math_1.Vec2(0.00, -0.90),
    new Math_1.Vec2(0.65, 0.24), new Math_1.Vec2(-0.65, 0.24),
    new Math_1.Vec2(-0.32, 0.63), new Math_1.Vec2(0.32, -0.65),
    new Math_1.Vec2(-0.32, -0.65), new Math_1.Vec2(0.32, 0.63),
    new Math_1.Vec2(0.65, -0.28), new Math_1.Vec2(-0.65, -0.28),
];
var PlayerLayer = /** @class */ (function (_super) {
    __extends(PlayerLayer, _super);
    function PlayerLayer(ecs, wsContext, id, grid, dieFn, name) {
        var _this = _super.call(this, "Player" + id, ecs) || this;
        _this.wsClient = wsContext;
        _this.playerID = id;
        _this.grid = grid;
        _this.dieFn = dieFn;
        _this.self.name = name;
        // Add status component to current entity
        _this.self.addStatus(
        // Attack
        20 + ((Math.random() * 10) * (Math.random() < 0.4 ? -1.0 : 1.0)), 
        // Speed
        0.04 + ((Math.random() * 0.02) * (Math.random() < 0.4 ? -1.0 : 1.0)), 
        // Health
        100 + ((Math.random() * 50) * (Math.random() < 0.4 ? -1.0 : 1.0)), 
        // Defense
        5 + ((Math.random() * 5) * (Math.random() < 0.4 ? -1.0 : 1.0)), 
        // Cooldown
        0.6 + ((Math.random() * 0.3) * (Math.random() < 0.4 ? -1.0 : 1.0))).setOnDie(function (status) { return _this.onDie(status); });
        // Add rigibody for current entity
        _this.self.addRigidbody(grid.intervalX * 1.7, grid.intervalY * 1.7);
        _this.self.getTransform().setPos(spawnPos[PlayerLayer.playerCount].x, spawnPos[PlayerLayer.playerCount].y);
        if (PlayerLayer.playerCount <= 28)
            PlayerLayer.playerCount++;
        else
            PlayerLayer.playerCount = 0;
        _this.self.addBehavior();
        // Start to listen for connection
        // this.conListener = this.wsClient.addConListener((ws) => this.onWsConnection(ws))
        _this.conListener = _this.wsClient.addListener("connection", function (ws) { return _this.onWsConnection(ws); });
        return _this;
    }
    PlayerLayer.prototype.onAttach = function () {
        // Create player entity in new client
        this.wsClient.broadcast(this.getBaseMsg("create"));
    };
    PlayerLayer.prototype.onUpdate = function (deltaTime) {
        var attacking = this.self.getBehavior().attacking;
        var velocity = this.self.getRigidbody().velocity;
        // Updating phase
        var theta = (0, Math_1.rad2deg)(Math.atan2(velocity.y, velocity.x));
        if (-45.0 < theta && theta <= 45.0) {
            if (attacking) {
                this.wsClient.broadcast(this.getBaseMsg("update", 0));
            }
            else {
                this.wsClient.broadcast(this.getBaseMsg("update", 4));
            }
        }
        else if (45.0 < theta && theta <= 135.0) {
            if (attacking) {
                this.wsClient.broadcast(this.getBaseMsg("update", 2));
            }
            else {
                this.wsClient.broadcast(this.getBaseMsg("update", 6));
            }
        }
        else if (135.0 < theta && theta <= 180 || theta <= -135.0 && theta >= -180) {
            if (attacking) {
                this.wsClient.broadcast(this.getBaseMsg("update", 1));
            }
            else {
                this.wsClient.broadcast(this.getBaseMsg("update", 5));
            }
        }
        else if (-135.0 < theta && theta <= -45.0) {
            if (attacking) {
                this.wsClient.broadcast(this.getBaseMsg("update", 3));
            }
            else {
                this.wsClient.broadcast(this.getBaseMsg("update", 7));
            }
        }
    };
    PlayerLayer.prototype.onDetach = function () {
        // Delete player entity in client
        this.wsClient.broadcast(this.getBaseMsg("delete"));
        // Remove connection listener
        // this.wsClient.remConListener(this.conListener);
        this.conListener.destroy();
        // Removes itself from the grid
        this.grid.removeDynamic(this.self);
        // Destroy the self entity
        this.self.destroy();
    };
    PlayerLayer.prototype.onWsConnection = function (ws) {
        this.wsClient.send(ws, this.getBaseMsg("create"));
        // Doesn't handle the event
        return false;
    };
    PlayerLayer.prototype.getBaseMsg = function (type, action) {
        if (action === void 0) { action = 0; }
        var status = this.self.getStatus();
        var pos = this.self.getTransform().pos;
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
    };
    // When player dies callback
    PlayerLayer.prototype.onDie = function (status) {
        console.log("Morreu: ", this.name);
        console.log("Resultados: ", status);
        var killer = this.self.getStatus().lastHit.name;
        this.wsClient.broadcast({
            killed: this.self.name,
            killer: killer,
            action: KillFeed_json_1.default.items[KillFeed_json_1.default.items.length * Math.random() | 0],
            msgType: "kill"
        });
        this.dieFn();
    };
    // For spawn point selection
    PlayerLayer.playerCount = 0;
    return PlayerLayer;
}(Layer_1.Layer));
exports.PlayerLayer = PlayerLayer;
