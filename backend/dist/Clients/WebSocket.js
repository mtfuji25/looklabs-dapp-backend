"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.WSClient = void 0;
var ws_1 = require("ws");
// For uuid generation
var uuid_1 = require("uuid");
var WSClient = /** @class */ (function () {
    function WSClient(host, port) {
        var _this = this;
        // TODO: finish msgListeners
        this.listeners = {};
        // handles incoming messages of corresponding types
        this.msgHandlers = {
            "game-status": function (data, client) {
                // Just allow one response
                var replied = false;
                // Generates replyable msg
                var replyable = {
                    content: data.content,
                    reply: function (msg) {
                        if (!replied) {
                            var serverMsg = {
                                uuid: data.uuid,
                                type: "response",
                                content: msg
                            };
                            client.send(JSON.stringify(serverMsg));
                            replied = true;
                        }
                    }
                };
                for (var _i = 0, _a = Object.values(_this.listeners); _i < _a.length; _i++) {
                    var listener = _a[_i];
                    if (listener.type == "game-status") {
                        if (listener.callback(replyable))
                            break;
                    }
                }
            }
        };
        this.host = host;
        this.port = port;
        this.server = new ws_1.WebSocketServer({
            port: this.port
        });
    }
    WSClient.prototype.handleMsgs = function (message, client) {
        // Parses current msg
        var data = JSON.parse(message.toString());
        console.log(data);
        this.msgHandlers[data.content.type](data, client);
    };
    WSClient.prototype.handleConnection = function (ws) {
        var _this = this;
        console.log("New client connected in WebSocketServer.");
        for (var _i = 0, _a = Object.values(this.listeners); _i < _a.length; _i++) {
            var listener = _a[_i];
            if (listener.type == "connection") {
                if (listener.callback(ws))
                    break;
            }
        }
        ws.on("message", function (message) {
            _this.handleMsgs(message, ws);
        });
    };
    WSClient.prototype.send = function (client, msg) {
        var serverMsg = {
            uuid: (0, uuid_1.v4)(),
            type: "send",
            content: msg
        };
        client.send(JSON.stringify(serverMsg));
    };
    WSClient.prototype.broadcast = function (msg) {
        var serverMsg = {
            uuid: (0, uuid_1.v4)(),
            type: "broadcast",
            content: msg
        };
        this.server.clients.forEach(function (client) {
            client.send(JSON.stringify(serverMsg));
        });
    };
    WSClient.prototype.start = function () {
        var _this = this;
        console.log("WebSocket client initing in port: ", this.port);
        this.server.on("connection", function (ws) { return _this.handleConnection(ws); });
    };
    WSClient.prototype.close = function () {
        console.log("WebSocket client closing in port: ", this.port);
        this.server.close();
    };
    WSClient.prototype.addListener = function (type, fn) {
        var _this = this;
        var id = (0, uuid_1.v4)();
        var listener = {
            type: type,
            callback: fn,
            destroy: function () { return _this.remListener(id); }
        };
        this.listeners[id] = listener;
        return listener;
    };
    WSClient.prototype.remListener = function (id) {
        delete this.listeners[id];
    };
    return WSClient;
}());
exports.WSClient = WSClient;
