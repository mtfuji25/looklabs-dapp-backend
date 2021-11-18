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
exports.AwaitLevel = void 0;
// Level imports
var Level_1 = require("../Core/Level");
var Lobby_1 = require("./Lobby");
var Interfaces_1 = require("../Clients/Interfaces");
var AwaitLevel = /** @class */ (function (_super) {
    __extends(AwaitLevel, _super);
    function AwaitLevel() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        // WebSocket listener id
        _this.listener = 0;
        _this.gameId = 0;
        _this.gameFound = false;
        return _this;
    }
    AwaitLevel.prototype.onStart = function () {
        var _this = this;
        // Add WebSocket listener
        this.listener = this.context.ws.addMsgListener(function (msg) { return _this.onServerMsg(msg); });
        this.checkForGame();
    };
    AwaitLevel.prototype.checkForGame = function () {
        var _this = this;
        this.context.strapi.getNearestGame()
            .then(function (game) {
            if (!game) {
                console.log("No scheduled game, awaiting ...");
                setTimeout(function () { return _this.checkForGame(); }, 2000);
            }
            else {
                console.log("Game found, awaiting to start ...");
                _this.gameFound = true;
                var now = Date.now();
                var nextGame = Date.parse(game.game_date);
                _this.gameId = game.id;
                setTimeout(function () { return _this.startLobby(); }, nextGame - now);
            }
        })
            .catch(function (err) {
            console.log("Failed while seraching game in strapi.");
            console.log(err);
            // Closes the engine
            _this.context.close = true;
        });
    };
    AwaitLevel.prototype.startLobby = function () {
        console.log("Initing new game ...");
        var msg = {
            msgType: "game-status",
            gameId: this.gameId,
            lastGameId: 0,
            gameStatus: "lobby"
        };
        this.context.ws.broadcast(msg);
        this.context.engine.loadLevel(new Lobby_1.LobbyLevel(this.context, "Lobby", this.gameId));
    };
    AwaitLevel.prototype.onUpdate = function (deltaTime) { };
    AwaitLevel.prototype.onClose = function () {
        // Removes msg listener
        this.context.ws.remMsgListener(this.listener);
    };
    AwaitLevel.prototype.onServerMsg = function (msg) {
        if (msg.content.type == Interfaces_1.requests.gameStatus) {
            var reply = {
                msgType: "game-status",
                gameId: this.gameId,
                lastGameId: 0,
                gameStatus: this.gameFound ? "awaiting" : "not-found"
            };
            msg.reply(reply);
        }
        return true;
    };
    return AwaitLevel;
}(Level_1.Level));
exports.AwaitLevel = AwaitLevel;
;
