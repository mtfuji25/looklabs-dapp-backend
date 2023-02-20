import WebSocket, { WebSocketServer } from "ws";

// For uuid generation
import { v4 as uuidv4 } from "uuid";
import {
    ListenerTypes,
    IncomingMsg,
    ServerMsg,
    ReplyableMsg,
    Listener,
    OnConnectionListener,
    OnConnectionFn,
    OnListenerFns,
    msgHandlerFn,
    MsgInterfaces,
    PlayerNames,
    GameState,
    ReplyableMsgListener,
    OnReplyableMsgFn,
} from "./Interfaces";
import { Logger } from "../Utils/Logger";

class WSClient {
    private host: string;
    private port: number;

    private server: WebSocketServer;

    private listeners: Record<string, Listener> = {};

    // handles incoming messages of corresponding types
    private msgHandlers: Record<string, msgHandlerFn> = {}

    constructor(host: string, port: number) {
        this.host = host;
        this.port = port;

        this.setListeners();

        this.server = new WebSocketServer({
            port: this.port
        });
    }

    private setListeners() {
        const msgs = ["map-data", "game-status", "player-names", "game-state"];

        msgs.forEach(msg => {
            this.msgHandlers[msg] = (data: IncomingMsg, client: WebSocket): void => {
                // Just allow one response
                let replied = false;
    
                // Generates replyable msg
                const replyable: ReplyableMsg = {
                    content: data.content,
                    reply: (msg: MsgInterfaces) => {
                        if (!replied) {
                            const serverMsg: ServerMsg = {
                                uuid: data.uuid,
                                type: "response",
                                content: msg
                            };
    
                            client.send(JSON.stringify(serverMsg));
    
                            replied = true;
                        }
                    }
                };
    
                for (let listener of Object.values(this.listeners)) {
                    if (listener.type == msg) {
                        if ((listener as ReplyableMsgListener).callback(replyable)) break;
                    }
                }
            }
        });
    }

    private handleMsgs(message: WebSocket.RawData, client: WebSocket) {
        // Parses current msg
        const data = JSON.parse(message.toString()) as IncomingMsg;

        this.msgHandlers[data.content.type](data, client);
    }

    private handleConnection(ws: WebSocket) {
        Logger.info("New client connected in WebSocketServer.");

        for (let listener of Object.values(this.listeners)) {
            if (listener.type == "connection") {
                if ((listener as OnConnectionListener).callback(ws)) break;
            }
        }

        ws.on("message", (message: WebSocket.RawData) => {
            this.handleMsgs(message, ws);
        });
    }

    send(client: WebSocket, msg: MsgInterfaces) {
        const serverMsg: ServerMsg = {
            uuid: uuidv4(),
            type: "send",
            content: msg
        };
        client.send(JSON.stringify(serverMsg));
    }

    broadcast(msg: MsgInterfaces) {
        const serverMsg: ServerMsg = {
            uuid: uuidv4(),
            type: "broadcast",
            content: msg
        };
        this.server.clients.forEach((client: WebSocket) => {
            client.send(JSON.stringify(serverMsg));
        });
    }

    start(): void {
        Logger.info("WebSocket client initing in port: ", this.port);

        this.server.on("connection", (ws) => this.handleConnection(ws));
    }

    close(): void {
        Logger.info("WebSocket client closing in port: ", this.port);
        this.server.close();
    }

    addListener(type: "map-data", fn: OnReplyableMsgFn): ReplyableMsgListener;
    addListener(type: "game-status", fn: OnReplyableMsgFn): ReplyableMsgListener;
    addListener(type: "game-state", fn: OnReplyableMsgFn): ReplyableMsgListener;
    addListener(type: "player-names", fn: OnReplyableMsgFn): ReplyableMsgListener;
    addListener(type: "connection", fn: OnConnectionFn): OnConnectionListener;
    addListener(type: ListenerTypes, fn: OnListenerFns): Listener {
        const id = uuidv4();

        const listener = {
            type: type,
            callback: fn,
            destroy: () => this.remListener(id),
            id: id
        };

        this.listeners[id] = listener;

        return listener;
    }

    remListener(id: string): void {
        delete this.listeners[id];
    }
}

export { WSClient, ReplyableMsg };
