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
Object.defineProperty(exports, "__esModule", { value: true });
exports.PlayerLayer = void 0;
var ecs_1 = require("../core/ecs/core/ecs");
var layer_1 = require("../core/layer");
var math_1 = require("../utils/math");
// Fixed spawn points
var spawnPos = [
    new math_1.Vec2(0.75, 0.0),
    new math_1.Vec2(0.5, 0.3),
    new math_1.Vec2(0.75, 0.7),
    new math_1.Vec2(-0.1, 0.53),
    new math_1.Vec2(0.75, 0.3),
    new math_1.Vec2(0.6, -0.4),
    new math_1.Vec2(-0.7, 0.6),
    new math_1.Vec2(-0.5, -0.4),
    new math_1.Vec2(-0.2, -0.6),
    new math_1.Vec2(0.2, -0.6),
];
var PlayerLayer = /** @class */ (function (_super) {
    __extends(PlayerLayer, _super);
    function PlayerLayer(ecs, wsContext, id, grid, requestTarget) {
        var _this = _super.call(this, "Player" + id, ecs) || this;
        _this.strength = 0;
        _this.attackVel = 0;
        _this.speed = 0;
        // OnDie event fn
        _this.onDie = function (player) { };
        // For attack purpose
        _this.hunted = false;
        _this.hunting = null;
        _this.attacking = null;
        _this.cooldown = 0;
        _this.hitting = 10;
        _this.wsClient = wsContext;
        _this.playerID = id;
        _this.grid = grid;
        _this.getTarget = requestTarget;
        // Init player's random status
        _this.speed = 0.02 + (Math.random() * 0.05);
        _this.strength = 20 + ((Math.random() * 50) * (Math.random() < 0.4 ? -1.0 : 1.0));
        _this.attackVel = 200 + ((Math.random() * 200) * (Math.random() < 0.4 ? -1.0 : 1.0));
        // Status component
        var status = _this.self.addComponent[ecs_1.Status](100 + ((Math.random() * 50) * (Math.random() < 0.4 ? -1.0 : 1.0)), 20 + ((Math.random() * 50) * (Math.random() < 0.4 ? -1.0 : 1.0)));
        // On die callback
        status.onSelfDie = function () {
            _this.onDie(_this);
            _this.self.removeComponent[ecs_1.Status]();
        };
        // Set spawn position
        var tranform = _this.self.getComponent[ecs_1.Transform]();
        tranform.pos = spawnPos[PlayerLayer.playerCount];
        // Add rectangle and rigidbody component
        _this.self.addComponent[ecs_1.Rectangle](grid.intervalX, grid.intervalY);
        var rg = _this.self.addComponent[ecs_1.Rigidbody]();
        // On collision callback function
        rg.onCollision = function (other, result) { return _this.onCollision(other, result); };
        if (PlayerLayer.playerCount < 10)
            PlayerLayer.playerCount++;
        return _this;
    }
    PlayerLayer.prototype.onAttach = function () {
        var _this = this;
        // Get current pleyr position
        var pos = this.self.getComponent[ecs_1.Transform]().pos;
        // Create player entity in new client
        this.wsClient.broadcast({ type: "create-enemy", content: { id: this.playerID, pos: { x: pos.x, y: pos.y } } });
        this.wsClient.addConListener(function (ws) { return _this.onWsConnection(ws); });
    };
    PlayerLayer.prototype.onUpdate = function (deltaTime) {
        var _this = this;
        var _a;
        // Seek the enemy
        if (!this.hunting) {
            this.hunting = this.getTarget(this);
            if (this.hunting) {
                var stats = (_a = this.hunting) === null || _a === void 0 ? void 0 : _a.getComponent[ecs_1.Status]();
                stats.notifyHunter = function () { return _this.onHuntedDead(); };
            }
        }
        else {
            var enemy = this.hunting.getComponent[ecs_1.Transform]();
            var player = this.self.getComponent[ecs_1.Transform]();
            var velocity = enemy.pos.sub(player.pos).normalize().muls(this.speed);
            var rg_1 = this.self.getComponent[ecs_1.Rigidbody]();
            rg_1.velocity = velocity;
        }
        // Performs the attack
        if (this.cooldown <= 0) {
            if (this.attacking) {
                var oponent = this.attacking.getComponent[ecs_1.Status]();
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
        var pos = this.self.getComponent[ecs_1.Transform]().pos;
        var rg = this.self.getComponent[ecs_1.Rigidbody]();
        var factor = rg.velocity.x / rg.velocity.y;
        if (this.hitting >= 0) {
            if (factor >= 1) {
                if (rg.velocity.x >= 0) {
                    this.wsClient.broadcast({ type: "update-enemy", content: { id: this.playerID, action: 0, pos: { x: pos.x, y: pos.y } } });
                }
                else {
                    this.wsClient.broadcast({ type: "update-enemy", content: { id: this.playerID, action: 1, pos: { x: pos.x, y: pos.y } } });
                }
            }
            else {
                if (rg.velocity.y >= 0) {
                    this.wsClient.broadcast({ type: "update-enemy", content: { id: this.playerID, action: 2, pos: { x: pos.x, y: pos.y } } });
                }
                else {
                    this.wsClient.broadcast({ type: "update-enemy", content: { id: this.playerID, action: 3, pos: { x: pos.x, y: pos.y } } });
                }
            }
        }
        else {
            if (factor >= 1) {
                if (rg.velocity.x >= 0) {
                    this.wsClient.broadcast({ type: "update-enemy", content: { id: this.playerID, action: 4, pos: { x: pos.x, y: pos.y } } });
                }
                else {
                    this.wsClient.broadcast({ type: "update-enemy", content: { id: this.playerID, action: 5, pos: { x: pos.x, y: pos.y } } });
                }
            }
            else {
                if (rg.velocity.y >= 0) {
                    this.wsClient.broadcast({ type: "update-enemy", content: { id: this.playerID, action: 6, pos: { x: pos.x, y: pos.y } } });
                }
                else {
                    this.wsClient.broadcast({ type: "update-enemy", content: { id: this.playerID, action: 7, pos: { x: pos.x, y: pos.y } } });
                }
            }
        }
    };
    PlayerLayer.prototype.onDetach = function () {
        // Delete player entity in client
        this.wsClient.broadcast({ type: "delete-enemy", content: { id: this.playerID } });
        // Removes itself from the grid
        this.grid.removeDynamic(this.self);
        // Destroy the self entity
        this.self.destroy();
    };
    PlayerLayer.prototype.onWsConnection = function (ws) {
        // Get current pleyr position
        var pos = this.self.getComponent[ecs_1.Transform]().pos;
        // Create player entity in new client
        ws.send(JSON.stringify({ type: "create-enemy", content: { id: this.playerID, pos: { x: pos.x, y: pos.y } } }));
        // Doesn't handle the event
        return false;
    };
    PlayerLayer.prototype.onCollision = function (other, result) {
        // If not other, so it's colliding with wall,
        // them try to solve by oposing velocity.
        if (!other) {
            var rg = this.self.getComponent[ecs_1.Rigidbody]();
            rg.velocity.x = result.contactNormal.x * this.speed * 2.0;
            rg.velocity.y = result.contactNormal.y * this.speed * 2.0;
            if (result.contactNormal.x == 0) {
                rg.velocity.x *= 1 + Math.random();
            }
            if (result.contactNormal.y == 0) {
                rg.velocity.y *= 1 + Math.random();
            }
        }
        else {
            this.attacking = other;
        }
    };
    PlayerLayer.prototype.setOnDie = function (fn) {
        this.onDie = fn;
    };
    PlayerLayer.prototype.onHuntedDead = function () {
        this.hunting = null;
    };
    // For spawn point selection
    PlayerLayer.playerCount = 0;
    return PlayerLayer;
}(layer_1.Layer));
exports.PlayerLayer = PlayerLayer;
