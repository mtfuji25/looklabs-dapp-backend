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
var ecs_1 = require("../core/ecs/core/ecs");
var level_1 = require("../core/level");
var mapcollider_1 = require("../layers/mapcollider");
var player_1 = require("../layers/player");
var await_1 = require("./await");
var LobbyLevel = /** @class */ (function (_super) {
    __extends(LobbyLevel, _super);
    function LobbyLevel(context, name, gameId) {
        var _this = _super.call(this, context, name) || this;
        _this.ready = false;
        _this.participants = [];
        _this.fighters = [];
        _this.gameId = gameId;
        return _this;
    }
    LobbyLevel.prototype.onStart = function () {
        var _this = this;
        this.context.strapiClient.getGameById(this.gameId)
            .then(function (game) {
            game.scheduled_game_participants.map(function (participant) {
                _this.participants.push(participant);
            });
            _this.startGame();
        }).catch(function (err) {
            console.log(err);
            _this.context.closeRequest = true;
        });
    };
    LobbyLevel.prototype.startGame = function () {
        var _this = this;
        var mapCollider = new mapcollider_1.MapColliderLayer(this.ecs);
        var grid = mapCollider.getSelf().getComponent[ecs_1.Grid]();
        this.layerStack.pushLayer(mapCollider);
        this.participants.map(function (participant) {
            var player = new player_1.PlayerLayer(_this.ecs, _this.context.wsClient, participant.id, grid, function (player) {
                var _a;
                var _b;
                for (var i = _this.fighters.length - 1; i > 0; --i) {
                    var j = Math.floor(Math.random() * (i + 1));
                    _a = [_this.fighters[j], _this.fighters[i]], _this.fighters[i] = _a[0], _this.fighters[j] = _a[1];
                }
                var prey = null;
                for (var _i = 0, _c = _this.fighters; _i < _c.length; _i++) {
                    var fighter = _c[_i];
                    if (fighter === player)
                        continue;
                    if (fighter.hunted)
                        continue;
                    prey = fighter;
                    fighter.hunted = true;
                    break;
                }
                if (!prey) {
                    for (var _d = 0, _e = _this.fighters; _d < _e.length; _d++) {
                        var fighter = _e[_d];
                        if (fighter === player)
                            continue;
                        prey = fighter;
                        break;
                    }
                }
                return (_b = prey === null || prey === void 0 ? void 0 : prey.getSelf()) !== null && _b !== void 0 ? _b : null;
            });
            grid.addDynamic(player.getSelf());
            player.setOnDie(function (data) {
                // Removes dead player from update cycle
                _this.layerStack.popLayer(data);
                // Removes dead player from fighters
                _this.fighters = _this.fighters.filter(function (item) { return item !== data; });
                console.log("Morreu: ", _this.fighters);
                // this.context.strapiClient.createParticipantResult({
                //     scheduled_game_participant: data.playerID,
                //     result: "died"
                // }).catch((err) => {
                //     console.log("Failed to store results in player: ", data.playerID);
                // })
            });
            _this.fighters.push(player);
            _this.layerStack.pushLayer(player);
        });
        this.ready = true;
    };
    LobbyLevel.prototype.onUpdate = function (deltaTime) {
        if (this.fighters.length <= 1 && this.ready) {
            this.context.engine.loadLevel(new await_1.AwaitLevel(this.context, "Await"));
        }
    };
    LobbyLevel.prototype.onClose = function () {
    };
    return LobbyLevel;
}(level_1.Level));
exports.LobbyLevel = LobbyLevel;
;
