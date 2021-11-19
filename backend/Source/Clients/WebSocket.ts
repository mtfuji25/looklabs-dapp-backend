import WebSocket, { WebSocketServer } from "ws";

// For uuid generation
import { v4 as uuidv4 } from "uuid";
import { Listeners, requests } from "./Interfaces";
import { IncomingMessage } from "../Clients/Interfaces";

// Callback types
type DestroyFn = (type: Listeners) => void;
type OnListenerFn = (event: WebSocket | ReplyableMsg) => boolean;

interface ReplyableMsg {
    content: any;
    reply: (msg: any) => void;
}

interface TypedCallback {
    type: Listeners;
    callback: OnListenerFn;
}

class Listener {

    public type: Listeners;
    private id: string;
    private client: WSClient;
    private destroyFn: DestroyFn;

    constructor(destroyFn: DestroyFn, type: Listeners, fn: OnListenerFn, id: string) {
        this.id = id;
        this.type = type;
        this.destroyFn = destroyFn;
    }

    destroy() {
        this.destroyFn(this.type);
    }
}

class WSClient {

    private host: string;
    private port: number;

    private server: WebSocketServer;

    // TODO: finish msgListeners
    private listeners: Record<string, TypedCallback> = {};

    constructor(host: string, port: number) {

        this.host =  host;
        this.port = port;
        
        this.server = new WebSocketServer({
            port: this.port
        });
    }

    private handleMsgs(message: WebSocket.RawData, client: WebSocket) {
        // Parses current msg
        const data = JSON.parse(message.toString()) as IncomingMessage;

        // Just allow one response
        let replied = false;

        // Generates replyable msg
        const replyable: ReplyableMsg = {
            content: data.
            reply: (msg: any) => {
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
        }

        for (let listener of Object.values(this.listeners)) {
            if (listener.type == data.type) {

            }
        }
    }

    private handleConnection(ws: WebSocket) {
        console.log("New client connected in WebSocketServer.");

        for (let listener of Object.values(this.listeners)) {
            if (listener.type == "connection") {
                if (listener.callback(ws))
                    break;
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
        }
        client.send(JSON.stringify(serverMsg));
    }

    broadcast(msg: any) {
        const serverMsg: ServerMsg = {
            uuid: uuidv4(),
            type: "broadcast",
            content: msg
        }
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
    
    addListener(type: Listeners, fn: OnListenerFn): Listener {
        const id = uuidv4();

        this.listeners[id] = { type: type, callback: fn };        

        return new Listener((type) => this.remListener(type), type, fn, id);
    }

    remListener(id: string): void {
        delete this.listeners[id];
    }
};

export { WSClient, ReplyableMsg };
