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
        _this.conListener = _this.context.ws.addListener("connection", function (ws) {
            setTimeout(function () {
                _this.context.ws.send(ws, {
                    msgType: "remain-players",
                    remainingPlayers: _this.participants.length,
                    totalPlayers: _this.participants.length
                });
            }, 1000);
            return false;
        });
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
        // Initial broadcast for players length
        this.context.ws.broadcast({
            msgType: "remain-players",
            remainingPlayers: this.participants.length,
            totalPlayers: this.participants.length
        });
        var responseCounter = 0;
        var responses = [];
        this.participants.map(function (participant) {
            var tokenId = Number((participant.nft_id).split('/')[1]);
            if (tokenId > 50)
                tokenId -= 50;
            console.log('TOKEN', tokenId);
            _this.context.strapi.getParticipantDetails(Number(tokenId)).then(function (response) {
                console.log(response);
                responses.push({
                    participant: participant,
                    response: response
                });
                responseCounter++;
                if (responseCounter == (_this.participants.length - 1)) {
                    // Put the map in the stack
                    _this.layerStack.pushLayer(mapCollider);
                    responses.map(function (_a) {
                        var participant = _a.participant, response = _a.response;
                        var details = response;
                        var player = new Player_1.PlayerLayer(_this.ecs, _this.context.ws, participant.nft_id, participant.id, grid, function (result) {
                            _this.ready = false;
                            _this.layerStack.popLayer(player);
                            // Esse vai para produção
                            console.log("Matou caramba");
                            _this.context.strapi.createParticipantResult(result).then(function () {
                                _this.ready = true;
                            }).catch(function (err) { return console.log(err); });
                            // Shoud be after create result
                            _this.fighters--;
                            _this.context.ws.broadcast({
                                msgType: "remain-players",
                                remainingPlayers: _this.fighters,
                                totalPlayers: _this.participants.length
                            });
                        }, details);
                        grid.addDynamic(player.getSelf());
                        _this.layerStack.pushLayer(player);
                    });
                    _this.ready = true;
                }
            });
        });
    };
    LobbyLevel.prototype.onUpdate = function (deltaTime) {
        var _this = this;
        // When game finished
        if (this.fighters <= 1 && this.ready) {
            // Find the last remain player
            this.layerStack.layers.map(function (layer) {
                if (layer instanceof Player_1.PlayerLayer) {
                    // Block update for re-running
                    _this.ready = false;
                    // Get status component
                    var status = layer.getSelf().getStatus();
                    // Tells front-ends that there is only one player
                    _this.context.ws.broadcast({
                        msgType: "remain-players",
                        remainingPlayers: _this.fighters,
                        totalPlayers: _this.participants.length
                    });
                    // Create last participant result
                    _this.context.strapi.createParticipantResult({
                        scheduled_game_participant: layer.strapiID,
                        survived_for: Math.floor(status.survived),
                        kills: Math.floor(status.kills),
                        health: Math.ceil(status.health)
                    }).then(function () {
                        // Tells frontends that is return to await from this gameId
                        var msg = {
                            msgType: "game-status",
                            gameId: _this.gameId,
                            lastGameId: 0,
                            gameStatus: "awaiting"
                        };
                        _this.context.ws.broadcast(msg);
                        // Change to await level
                        _this.context.engine.loadLevel(new Await_1.AwaitLevel(_this.context, "Await"));
                    });
                }
            });
        }
    };
    LobbyLevel.prototype.onClose = function () {
        this.layerStack.destroy();
        this.listener.destroy();
        this.conListener.destroy();
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
