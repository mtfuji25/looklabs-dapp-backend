"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const WebSocket = require("ws");
const wss = new WebSocket.Server({ port: 8082 });
wss.on("connection", ws => {
    console.log("New client connected");
});
//# sourceMappingURL=index.js.map