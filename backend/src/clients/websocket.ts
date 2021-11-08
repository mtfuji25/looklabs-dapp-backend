
import WebSocket, { WebSocketServer } from "ws";

type OnConnectFn = (ws: WebSocket) => boolean;
type OnMsgFn = (message: WebSocket.RawData) => boolean;

class WSClient {

    private port: number;
    private server: WebSocketServer;
    private conListeners: OnConnectFn[] = [];
    private msgListeners: OnMsgFn[] = [];

    constructor(port: number) {
        this.port = port;
        this.server = new WebSocketServer({
            port: this.port
        });
    }

    private handleMsgs(message: WebSocket.RawData) {
        for (let listener of this.msgListeners) {
            if (listener(message))
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
            this.handleMsgs(message);
        });
    }

    broadcast(msg: any) {
        this.server.clients.forEach((client: WebSocket) => {
            client.send(JSON.stringify(msg));
        });
    }

    start(): void {
        console.log("WebSocket client initing in port: ", this.port);

        this.server.on("connection", (ws) => this.handleConnection(ws));
    }

    close(): void {
        console.log("WebSocket client closing in port: ", this.port);
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

export { WSClient };
