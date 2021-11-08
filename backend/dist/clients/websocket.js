"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.WSClient = void 0;
var ws_1 = require("ws");
var WSClient = /** @class */ (function () {
    function WSClient(port) {
        this.conListeners = [];
        this.msgListeners = [];
        this.port = port;
        this.server = new ws_1.WebSocketServer({
            port: this.port
        });
    }
    WSClient.prototype.handleMsgs = function (message) {
        for (var _i = 0, _a = this.msgListeners; _i < _a.length; _i++) {
            var listener = _a[_i];
            if (listener(message))
                break;
        }
    };
    WSClient.prototype.handleConnection = function (ws) {
        var _this = this;
        console.log("New client connected in WebSocketServer.");
        for (var _i = 0, _a = this.conListeners; _i < _a.length; _i++) {
            var listener = _a[_i];
            if (listener(ws))
                break;
        }
        ws.on("message", function (message) {
            _this.handleMsgs(message);
        });
    };
    WSClient.prototype.broadcast = function (msg) {
        this.server.clients.forEach(function (client) {
            client.send(JSON.stringify(msg));
        });
    };
    WSClient.prototype.start = function () {
        var _this = this;
        console.log("WebSocket client initing in port: ", this.port);
        this.server.on("connection", function (ws) { return _this.handleConnection(ws); });
    };
    WSClient.prototype.close = function () {
        console.log("WebSocket client closing in port: ", this.port);
    };
    WSClient.prototype.addConListener = function (fn) {
        this.conListeners.push(fn);
        return this.conListeners.length - 1;
    };
    WSClient.prototype.addMsgListener = function (fn) {
        this.msgListeners.push(fn);
        return this.msgListeners.length - 1;
    };
    WSClient.prototype.remConListener = function (id) {
        this.conListeners.slice(id, 1);
    };
    WSClient.prototype.remMsgListener = function (id) {
        this.msgListeners.slice(id, 1);
    };
    return WSClient;
}());
exports.WSClient = WSClient;
;
