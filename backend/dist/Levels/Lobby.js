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
exports.LobbyLevel = void 0;
// Level imports
var Level_1 = require("../Core/Level");
var Await_1 = require("./Await");
// Layers import
var Player_1 = require("../Layers/Lobby/Player");
var MapCollider_1 = require("../Layers/Lobby/MapCollider");
var Interfaces_1 = require("../Clients/Interfaces");
var LobbyLevel = /** @class */ (function (_super) {
    __extends(LobbyLevel, _super);
    function LobbyLevel(context, name, gameId) {
        var _this = _super.call(this, context, name) || this;
        // Current game participants
        _this.participants = [];
        _this.fighters = 0;
        // Tells when game is ready to play
        _this.ready = false;
        _this.gameId = gameId;
        _this.listener = _this.context.ws.addListener("game-status", function (msg) { return _this.onServerMsg(msg); });
        return _this;
    }
    LobbyLevel.prototype.onStart = function () {
        var _this = this;
        this.context.strapi.getGameById(this.gameId)
            .then(function (game) {
            game.scheduled_game_participants.map(function (participant) {
                _this.participants.push(participant);
                _this.fighters++;
            });
            _this.startGame();
        }).catch(function (err) {
            console.log(err);
            _this.context.close = true;
        });
    };
    LobbyLevel.prototype.startGame = function () {
        var _this = this;
        var mapCollider = new MapCollider_1.MapColliderLayer(this.ecs);
        var grid = mapCollider.getSelf().getGrid();
        // Put the map in the stack
        this.layerStack.pushLayer(mapCollider);
        // Initial broadcast for players length
        this.context.ws.broadcast({
            msgType: "remain-players",
            remainingPlayers: this.participants.length,
            totalPlayers: this.participants.length
        });
        this.participants.map(function (participant) {
            var player = new Player_1.PlayerLayer(_this.ecs, _this.context.ws, participant.nft_id, participant.id, grid, function (result) {
                _this.ready = false;
                _this.layerStack.popLayer(player);
                _this.fighters--;
                // Esse vai para produção
                console.log("Matou caramba");
                _this.context.strapi.createParticipantResult(result).then(function () { return _this.ready = true; }).catch(function (err) { return console.log(err); });
                _this.context.ws.broadcast({
                    msgType: "remain-players",
                    remainingPlayers: _this.fighters,
                    totalPlayers: _this.participants.length
                });
            }, participant.name);
            grid.addDynamic(player.getSelf());
            _this.layerStack.pushLayer(player);
        });
        // Tells that lobby is ready to play
        this.ready = true;
    };
    LobbyLevel.prototype.onUpdate = function (deltaTime) {
        var _this = this;
        if (this.fighters <= 1 && this.ready) {
            this.layerStack.layers.map(function (layer) {
                if (layer instanceof Player_1.PlayerLayer) {
                    var status = layer.getSelf().getStatus();
                    _this.ready = false;
                    _this.context.ws.broadcast({
                        msgType: "remain-players",
                        remainingPlayers: _this.fighters,
                        totalPlayers: _this.participants.length
                    });
                    _this.context.strapi.createParticipantResult({
                        scheduled_game_participant: layer.strapiID,
                        survived_for: Math.floor(status.survived),
                        kills: Math.floor(status.kills),
                        health: Math.floor(status.health)
                    }).then(function () {
                        var msg = {
                            msgType: "game-status",
                            gameId: _this.gameId,
                            lastGameId: 0,
                            gameStatus: "awaiting"
                        };
                        _this.context.ws.broadcast(msg);
                        _this.context.engine.loadLevel(new Await_1.AwaitLevel(_this.context, "Await"));
                    });
                }
            });
        }
    };
    LobbyLevel.prototype.onClose = function () {
        this.layerStack.destroy();
        this.listener.destroy();
    };
    LobbyLevel.prototype.onServerMsg = function (msg) {
        if (msg.content.type == Interfaces_1.requests.gameStatus) {
            var reply = {
                msgType: "game-status",
                gameId: this.gameId,
                lastGameId: 0,
                gameStatus: "lobby"
            };
            msg.reply(reply);
        }
        return true;
    };
    return LobbyLevel;
}(Level_1.Level));
exports.LobbyLevel = LobbyLevel;
;
