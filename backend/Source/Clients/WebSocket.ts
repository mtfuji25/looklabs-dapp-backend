import WebSocket, { WebSocketServer } from "ws";

// For uuid generation
import { v4 as uuidv4 } from "uuid";
import { ListenerTypes, IncomingMsg, ServerMsg, ReplyableMsg, GameStatus, Listener, GameStatusListener, OnConnectionListener, OnGameStatusFn, OnConnectionFn, OnListenerFns, msgHandlerFn } from "./Interfaces";


class WSClient {
    private host: string;
    private port: number;

    private server: WebSocketServer;

    // TODO: finish msgListeners
    private listeners: Record<string, Listener> = {};

    // handles incoming messages of corresponding types
    private readonly msgHandlers: Record<string, msgHandlerFn> = {
        "game-status": (data: IncomingMsg, client: WebSocket): void => {
            // Just allow one response
            let replied = false;

            // Generates replyable msg
            const replyable: ReplyableMsg = {
                content: data.content,
                reply: (msg: GameStatus) => {
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
                if (listener.type == "game-status") {
                    if ((listener as GameStatusListener).callback(replyable)) break;
                }
            }
        }
    };

    constructor(host: string, port: number) {
        this.host = host;
        this.port = port;

        this.server = new WebSocketServer({
            port: this.port
        });
    }

    private handleMsgs(message: WebSocket.RawData, client: WebSocket) {
        // Parses current msg
        const data = JSON.parse(message.toString()) as IncomingMsg;

        // try catch for the moment, while frontend is not updated
        try {
            this.msgHandlers[data.content.type](data, client);
        } catch(err) {
            console.log(err);
        }
    }

    private handleConnection(ws: WebSocket) {
        console.log("New client connected in WebSocketServer.");

        for (let listener of Object.values(this.listeners)) {
            if (listener.type == "connection") {
                if ((listener as OnConnectionListener).callback(ws)) break;
            }
        }

        ws.on("message", (message: WebSocket.RawData) => {
            this.handleMsgs(message, ws);
        });
    }

    send(client: WebSocket, msg: any) {
        const serverMsg: ServerMsg = {
            uuid: uuidv4(),
            type: "send",
            content: msg
        };
        client.send(JSON.stringify(serverMsg));
    }

    broadcast(msg: any) {
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
        console.log("WebSocket client initing in port: ", this.port);

        this.server.on("connection", (ws) => this.handleConnection(ws));
    }

    close(): void {
        console.log("WebSocket client closing in port: ", this.port);
        this.server.close();
    }

    addListener(type: "game-status", fn: OnGameStatusFn): GameStatusListener;
    addListener(type: "connection", fn: OnConnectionFn): OnConnectionListener;
    addListener(type: ListenerTypes, fn: OnListenerFns): Listener {
        const id = uuidv4();

        const listener = {
            type: type,
            callback: fn,
            destroy: () => this.remListener(id)
        };

        this.listeners[id] = listener;

        return listener;
    }

    remListener(id: string): void {
        delete this.listeners[id];
    }
}

export { WSClient, ReplyableMsg };
