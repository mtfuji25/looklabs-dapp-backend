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
        this.participants.map(function (participant, index) {
            var player = new Player_1.PlayerLayer(_this.ecs, _this.context.ws, participant.nft_id, grid, function () {
                _this.context.ws.broadcast({
                    msgType: "remain-players",
                    remainingPlayers: _this.fighters,
                    totalPlayers: _this.participants.length
                });
                _this.layerStack.popLayer(player);
                _this.fighters--;
            }, participant.name);
            grid.addDynamic(player.getSelf());
            _this.layerStack.pushLayer(player);
        });
        // Tells that lobby is ready to play
        this.ready = true;
    };
    LobbyLevel.prototype.onUpdate = function (deltaTime) {
        if (this.fighters <= 1 && this.ready) {
            this.context.engine.loadLevel(new Await_1.AwaitLevel(this.context, "Await"));
        }
    };
    LobbyLevel.prototype.onClose = function () {
        this.listener.destroy();
        // this.context.ws.remMsgListener(this.listener);
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
