
import { v4 as uuidv4 } from "uuid";

// Server interfaces

interface ServerResponse {
    uuid: string;
    type: "response" | "broadcast" | "send";
    content: any;
}

// Server callbacks types
type OnReadyFn = () => void;
type OnEventFn = (event: Event) => boolean;
type OnMsgFn = (message: ServerResponse) => boolean;

class WSClient {

    // Server settings
    private host: string;
    private port: number;
    private socket: WebSocket;

    // Client status
    private connected: boolean = false;
    private reconnect: boolean = true;

    // Client events listeners
    private conListeners: OnEventFn[] = [];
    private conLostListeners: OnEventFn[] = [];
    private onReadyListeners: OnReadyFn[] = [];

    // Listeners to server msgs
    private msgListeners: OnMsgFn[] = [];

    // Reponses listeners
    private responseListeners: OnMsgFn[] = [];

    constructor(host: string, port: number) {
        this.host = host;
        this.port = port;

        console.log("WebSocket client initing in host: ", this.host);
    }

    private handleServerMsg(message: any) {
        const data = JSON.parse(message.data) as ServerResponse;

        if (data.type == "broadcast" || data.type == "send") {
            for (let listener of this.msgListeners) {
                if (listener(data))
                    break;
            }
        } else {
            for (let listener of this.responseListeners) {
                if (listener(data))
                    break;
            }
        }
    }

    private onConnectionReady(event: Event) {
        this.connected =  true;
        
        for (let listener of this.conListeners) {
            if (listener(event))
                break;
        }

        for (let onReady of this.onReadyListeners) {
            onReady();
        }
        
        this.onReadyListeners = [];

        this.socket.addEventListener("message", (message) => {
            this.handleServerMsg(message);
        });
    }

    private onConnectionLost(event: Event) {
        this.connected = false;

        for (let listener of this.conLostListeners) {
            if (listener(event))
                break;
        }
    }

    request(message: any): Promise<ServerResponse> {
        return new Promise<ServerResponse>((resolve, reject) => {
            if (this.connected) {
                const msguuid = uuidv4();

                // Sends the request to the server
                this.socket.send(
                    JSON.stringify({
                        uuid: msguuid,
                        type: "request",
                        content: message
                    })
                );

                // Add response listener
                const fnId = this.addResponseListener((msg: ServerResponse) => {
                    if (msg.type == "response" && msg.uuid == msguuid) {
                        this.remResponseListener(fnId);
                        resolve(msg);
                        return true;
                    }
                    return false;
                });

                // If there is no response in 2 seconds reject
                setTimeout(() => { 
                    this.remResponseListener(fnId);
                    reject("Request timeout.") 
                }, 2000);
            } else {
                reject("Client is not connect to backend.");
            }
        });
    }

    start(): void {
        this.socket = new WebSocket(
            `${this.host}:${this.port}`
        );

        this.socket.addEventListener("open", (event) => {
            console.log("Connected to backend.");

            this.onConnectionReady(event);
        });

        this.socket.addEventListener("close", (event) => {
            this.onConnectionLost(event);
            
            if (this.reconnect) {
                setTimeout(() => {
                    console.log("Trying to reconnect...");
                    this.start();
                }, 1000);
            }
        });
    }

    close(): void {
        console.log("WebSocket client closing in host: ", this.host);

        this.reconnect = false;
        this.socket.close();
    }
    
    private addResponseListener(fn: OnMsgFn): number {
        this.responseListeners.push(fn);
        return this.responseListeners.length - 1;
    }
    private remResponseListener(id: number) {
        this.responseListeners.slice(id, 1);
    }

    onReady(fn: OnReadyFn) {
        if (this.connected) {
            fn();
        } else {
            this.onReadyListeners.push(fn);
        }
    }

    addConListener(fn: OnEventFn): number {
        this.conListeners.push(fn);
        return this.conListeners.length - 1;
    }

    addConLostListener(fn: OnEventFn): number {
        this.conLostListeners.push(fn);
        return this.conLostListeners.length - 1;
    }

    addMsgListener(fn: OnMsgFn): number {
        this.msgListeners.push(fn);
        return this.msgListeners.length - 1;
    }

    remConListener(id: number) {
        this.conListeners.slice(id, 1);
    }

    remConLostListener(id: number) {
        this.conLostListeners.slice(id, 1);
    }

    remMsgListener(id: number) {
        this.msgListeners.slice(id, 1);
    }

};

export { WSClient, ServerResponse };
