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
        this.context.strapi.getNearestGame()
            .then(function (game) {
            if (!game) {
                console.log("No scheduled game, awaiting ...");
                _this.context.strapi.onWebhook(function (game) { return _this.onStrapiHook(game); });
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
    AwaitLevel.prototype.onStrapiHook = function (game) {
        var _this = this;
        console.log("Game found, awaiting to start ...");
        this.gameFound = true;
        var now = Date.now();
        var nextGame = Date.parse(game.game_date);
        this.gameId = game.id;
        setTimeout(function () { return _this.startLobby(); }, nextGame - now);
    };
    AwaitLevel.prototype.startLobby = function () {
        console.log("Initing new game ...");
        // this.context.engine.loadLevel(
        //     new LobbyLevel(this.context, "Lobby", this.gameId)
        // );
    };
    AwaitLevel.prototype.onUpdate = function (deltaTime) { };
    AwaitLevel.prototype.onClose = function () {
        // Removes msg listener
        this.context.ws.remMsgListener(this.listener);
    };
    AwaitLevel.prototype.onServerMsg = function (msg) {
        if (msg.content.type == "game-data") {
            msg.reply({
                gameId: this.gameId,
                gameFound: this.gameFound
            });
        }
        return true;
    };
    return AwaitLevel;
}(Level_1.Level));
exports.AwaitLevel = AwaitLevel;
;
