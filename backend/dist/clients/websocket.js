"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.WSClient = void 0;
var WSClient = /** @class */ (function () {
    function WSClient(port) {
        this.port = port;
    }
    WSClient.prototype.start = function () {
        console.log("Port of client is", this.port);
    };
    WSClient.prototype.close = function () {
        console.log("Closing client in port", this.port);
    };
    return WSClient;
}());
exports.WSClient = WSClient;
;
