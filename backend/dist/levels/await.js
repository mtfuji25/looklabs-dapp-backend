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
var level_1 = require("../core/level");
var lobby_1 = require("./lobby");
var AwaitLevel = /** @class */ (function (_super) {
    __extends(AwaitLevel, _super);
    function AwaitLevel() {
        var _this = _super !== null && _super.apply(this, arguments) || this;
        _this.handleStrapiId = 0;
        _this.gameId = 0;
        return _this;
    }
    AwaitLevel.prototype.onStart = function () {
        var _this = this;
        this.context.strapiClient.getNearestGame()
            .then(function (game) {
            if (!game) {
                console.log("No scheduled game, awaiting ...");
                _this.handleStrapiId = _this.context.strapiClient.addMsgListener(function (msg) { return _this.handleStrapiMsg(msg); });
            }
            else {
                console.log("Game found, awaiting to start ...");
                var now = Date.now();
                var nextGame = Date.parse(game.game_date);
                _this.gameId = game.id;
                setTimeout(function () { return _this.startLobby(); }, nextGame - now);
            }
        }).catch(function (err) {
            console.log(err);
            _this.context.closeRequest = true;
        });
    };
    AwaitLevel.prototype.handleStrapiMsg = function (game) {
        var _this = this;
        console.log("Game found, awaiting to start ...");
        var now = Date.now();
        var nextGame = Date.parse(game.game_date);
        this.gameId = game.id;
        setTimeout(function () { return _this.startLobby(); }, nextGame - now);
        this.context.strapiClient.remMsgListener(this.handleStrapiId);
        return false;
    };
    AwaitLevel.prototype.startLobby = function () {
        console.log("Initing new game ...");
        this.context.engine.loadLevel(new lobby_1.LobbyLevel(this.context, "Lobby", this.gameId));
    };
    AwaitLevel.prototype.onUpdate = function (deltaTime) { };
    AwaitLevel.prototype.onClose = function () { };
    return AwaitLevel;
}(level_1.Level));
exports.AwaitLevel = AwaitLevel;
;
