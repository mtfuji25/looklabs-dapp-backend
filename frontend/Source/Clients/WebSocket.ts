
import { v4 as uuidv4 } from "uuid";

// Server interfaces

interface ServerResponse {
    uuid: string;
    type: "response" | "broadcast" | "send";
    content: {
        msgType: string
    } & {
        [key: string]: any;
    };
}

// Server callbacks types
type OnReadyFn = () => void;
type OnEventFn = (event: Event) => boolean;
type OnMsgFn = (message: ServerResponse) => boolean;

class WSClient {

    // Server settings
    private host: string;
    private socket: WebSocket;

    // Client status
    private connected: boolean = false;
    private reconnect: boolean = true;

    // Client events listeners
    private conListeners: Record<string, OnEventFn> = {};
    private conLostListeners: Record<string, OnEventFn> = {};

    // When server is ready to requests
    private onReadyListeners: OnReadyFn[] = [];

    // Listeners to server msgs
    private msgListeners: Record<string, OnMsgFn> = {};

    // Reponses listeners
    private responseListeners: Record<string, OnMsgFn> = {};

    constructor(host: string) {
        this.host = host;

        console.log("WebSocket client initing in host: ", this.host);
    }

    private handleServerMsg(message: any) {
        const data = JSON.parse(message.data) as ServerResponse;

        if (data.type == "broadcast" || data.type == "send") {
            for (let listener of Object.values(this.msgListeners)) {
                if (listener(data))
                    break;
            }
        } else {
            for (let listener of Object.values(this.responseListeners)) {
                if (listener(data))
                    break;
            }
        }
    }

    private onConnectionReady(event: Event) {
        this.connected =  true;
        
        for (let listener of Object.values(this.conListeners)) {
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

        for (let listener of Object.values(this.conLostListeners)) {
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
            `${this.host}`
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
    
    private addResponseListener(fn: OnMsgFn): string {
        const id: string = uuidv4();
        this.responseListeners[id] = fn;
        
        return id;
    }

    private remResponseListener(id: string): void {
        delete this.responseListeners[id];
    }

    onReady(fn: OnReadyFn) {
        if (this.connected) {
            fn();
        } else {
            this.onReadyListeners.push(fn);
        }
    }

    //
    //  Listeners to add and remove ids
    //

    addConListener(fn: OnEventFn): string {
        const id: string = uuidv4();
        this.conListeners[id] = fn;

        return id;
    }

    addConLostListener(fn: OnEventFn): string {
        const id: string = uuidv4();
        
        this.conLostListeners[id] = fn;
        return id;
    }

    addMsgListener(fn: OnMsgFn): string {
        const id: string = uuidv4();
        this.msgListeners[id] = fn;
        
        return id;
    }

    remConListener(id: string): void {
        delete this.conListeners[id];
    }

    remConLostListener(id: string): void {
        delete this.conLostListeners[id];
    }

    remMsgListener(id: string): void {
        delete this.msgListeners[id];
    }

};

export { WSClient, ServerResponse };
