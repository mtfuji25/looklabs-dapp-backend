import WebSocket, { WebSocketServer } from "ws";

// For uuid generation
import { v4 as uuidv4 } from "uuid";

interface ServerMsg {
    uuid: string;
    type: "response" | "broadcast" | "send";
    content: any;
}

interface ReplyableMsg {
    content: any;
    reply: (msg: any) => void;
}

type OnConnectFn = (ws: WebSocket) => boolean;
type OnMsgFn = (message: ReplyableMsg) => boolean;

class WSClient {

    private host: string;
    private port: number;

    private server: WebSocketServer;
    private conListeners: OnConnectFn[] = [];
    private msgListeners: OnMsgFn[] = [];

    constructor(host: string, port: number) {

        this.host =  host;
        this.port = port;
        
        this.server = new WebSocketServer({
            port: this.port
        });
    }

    private handleMsgs(message: WebSocket.RawData, client: WebSocket) {
        // Parses current msg
        const data = JSON.parse(message.toString()) as ServerMsg;

        // Just allow one response
        let replied = false;

        // Generates replyable msg
        const replyable: ReplyableMsg = {
            content: data.content,
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
        for (let listener of this.msgListeners) {
            if (listener(replyable))
                break;
        }
    }

    private handleConnection(ws: WebSocket) {
        console.log("New client connected in WebSocketServer.");
        for (let listener of this.conListeners) {
            if (listener(ws))
                break;
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
    
    addConListener(fn: OnConnectFn): number {
        this.conListeners.push(fn);
        return this.conListeners.length - 1;
    }

    addMsgListener(fn: OnMsgFn): number {
        this.msgListeners.push(fn);
        return this.msgListeners.length - 1;
    }

    remConListener(id: number) {
        this.conListeners.slice(id, 1);
    }

    remMsgListener(id: number) {
        this.msgListeners.slice(id, 1);
    }

};

export { WSClient, ReplyableMsg };
