"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.Engine = void 0;
var default_1 = require("../levels/default");
var Engine = /** @class */ (function () {
    function Engine(wsClient) {
        this.wsClient = wsClient;
    }
    Engine.prototype.start = function () {
        console.log("starting engine");
        // Start engine Web Socket client
        this.wsClient.start();
        // Finally load the default level
        this.loadLevel(new default_1.DefaultLevel());
    };
    Engine.prototype.loop = function () {
        console.log("looping engine");
    };
    Engine.prototype.close = function () {
        // Close engine Web Socket client
        this.wsClient.close();
        console.log("closing engine");
    };
    Engine.prototype.loadLevel = function (level) {
        console.log("loading level in engine");
    };
    return Engine;
}());
exports.Engine = Engine;
;
