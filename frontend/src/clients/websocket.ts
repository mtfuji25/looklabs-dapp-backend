
type OnConnectFn = (event: Event) => boolean;
type OnConLostFn = (event: Event) => boolean;

type OnMsgFn = (message: any) => boolean;

class WSClient {

    // Server settings
    private host: string;
    private socket: WebSocket;

    // Client status
    private connected: boolean = false;
    private reconnect: boolean = true;

    // Client events listeners
    private conListeners: OnConnectFn[] = [];
    private conLostListeners: OnConLostFn[] = [];

    // Listeners to server msgs
    private msgListeners: OnMsgFn[] = [];

    constructor(host: string) {
        this.host = host;

        console.log("WebSocket client initing in host: ", this.host);
    }

    private handleServerMsg(message: any) {
        const data = JSON.parse(message.data);

        for (let listener of this.msgListeners) {
            if (listener(data))
                break;
        }
    }

    private onConnectionReady(event: Event) {
        this.connected =  true;

        for (let listener of this.conListeners) {
            if (listener(event))
                break;
        }

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

    request(message: any) {
        if (this.connected) {
            this.socket.send(
                JSON.stringify(message)
            );
        }
    }

    start(): void {
        this.socket = new WebSocket(
            this.host
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
    
    addConListener(fn: OnConnectFn): number {
        this.conListeners.push(fn);
        return this.conListeners.length - 1;
    }

    addConLostListener(fn: OnConLostFn): number {
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

export { WSClient };
