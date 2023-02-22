import { v4 as uuidv4 } from "uuid";
import { Logger } from "../Utils/Logger";
import {
    ConnectionLostListener,
    Listener,
    ListenerTypes,
    msgHandlerFn,
    OnConnectionFn,
    OnConnectionListener,
    OnConnectionLostFn,
    OnListenerFns,
    OnServerMsgFn,
    RequestMsg,
    ServerMsg,
    ServerMsgListener
} from "./Interfaces";

// Server callbacks types
type OnReadyFn = () => void;

class WSClient {
    // Server settings
    private host: string;
    private port: number;
    private socket: WebSocket;

    // Client status
    private connected: boolean = false;
    private reconnect: boolean = true;

    private listeners: Record<string, Listener> = {};

    // When server is ready to requests
    private onReadyListeners: OnReadyFn[] = [];

    // msg handler record for each msg type
    private msgHandlers: Record<string, msgHandlerFn> = {}

    constructor(host: string, port: number) {
        this.host = host;
        this.port = port;

        this.setListeners();

        if (process.env.NODE_ENV != "production" && !this.port) {
            console.warn(
                "Port is not set in local developent this should be set: ",
                `${this.host}:${this.port}`
            );
        }

        Logger.info("WebSocket client initing in host: ", `${this.host}`);
    }

    private setListeners() {
        const msgs = ["map-data", "game-status", "kill", "remain-players", "enemy", "game-time", "game-state"];

        msgs.forEach(msg => {
            this.msgHandlers[msg] = (data: ServerMsg): void => {
                for (let listener of Object.values(this.listeners)) {
                    if (listener.type == msg) {
                        if ((listener as ServerMsgListener).callback(data)) break;
                    }
                }
            }
        });
    }

    private handleServerMsg(message: any) {
        const data = JSON.parse(message.data) as ServerMsg;

        if (data.type == "broadcast" || data.type == "send") {
            this.msgHandlers[data.content.msgType](data);
        } else {
            for (let listener of Object.values(this.listeners)) {
                if (listener.type == "response") {
                    if ((listener as ServerMsgListener).callback(data)) break;
                }
            }
        }
    }

    private onConnectionReady(event: Event) {
        this.connected = true;

        for (let listener of Object.values(this.listeners)) {
            if (listener.type == "connection") {
                if ((listener as OnConnectionListener).callback(event)) break;
            }
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

        for (let listener of Object.values(this.listeners)) {
            if (listener.type == "connection-lost") {
                if ((listener as ConnectionLostListener).callback(event)) break;
            }
        }
    }

    request(message: RequestMsg): Promise<ServerMsg> {
        return new Promise<ServerMsg>((resolve, reject) => {
            if (this.connected) {
                // Sends the request to the server
                this.socket.send(JSON.stringify(message));

                // Add response listener
                const responseListener = this.addListener("response", (msg: ServerMsg) => {
                    if (msg.type == "response" && msg.uuid == message.uuid) {
                        this.remListener(responseListener.id);
                        resolve(msg);
                        return true;
                    }
                    return false;
                });

                // If there is no response in 2 seconds reject
                setTimeout(() => {
                    this.remListener(responseListener.id);
                    reject("Request timeout.");
                }, 5000);
            } else {
                reject("Client is not connect to backend.");
            }
        });
    }

    start(): void {
        // In production PORT is not required due to load balancing check if port is set
        const connectionString = this.port ? `${this.host}:${this.port}` : `${this.host}`;

        this.socket = new WebSocket(connectionString);

        this.socket.addEventListener("open", (event) => {
            Logger.info("Connected to backend.");

            this.onConnectionReady(event);
        });

        this.socket.addEventListener("close", (event) => {
            this.onConnectionLost(event);

            if (this.reconnect) {
                setTimeout(() => {
                    Logger.info("Trying to reconnect...");
                    this.start();
                }, 1000);
            }
        });
    }

    close(): void {
        Logger.info("WebSocket client closing in host: ", this.host);

        this.reconnect = false;
        this.socket.close();
    }

    onReady(fn: OnReadyFn) {
        if (this.connected) {
            fn();
        } else {
            this.onReadyListeners.push(fn);
        }
    }

    async whenReady(): Promise<void> {
        return new Promise((resolve, reject) => {
            const checkConnection = () => {
                if (this.connected) {
                    resolve();
                } else {
                    setTimeout(checkConnection, 1000);
                }
            };
            checkConnection();
        });
    }

    //
    //  Listeners to add and remove ids
    //

    addListener(type: "connection", fn: OnConnectionFn): OnConnectionListener;
    addListener(type: "connection-lost", fn: OnConnectionLostFn): ConnectionLostListener;
    addListener(type: ListenerTypes, fn: OnServerMsgFn): ServerMsgListener;
    addListener(type: ListenerTypes, fn: OnListenerFns): Listener {
        const id = uuidv4();
        Logger.info("Adding listener: ", id);
        Logger.info("Listeners: ", this.listeners);

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
        Logger.info("Removing Listener: ", id);
        delete this.listeners[id];
    }

    isConnected() {
        return this.connected;
    }
}

export { WSClient };
