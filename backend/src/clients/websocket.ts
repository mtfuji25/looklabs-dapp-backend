
class WSClient {

    private port: number;

    constructor(port: number) {
        this.port = port;
    }

    start(): void {
        console.log("Port of client is", this.port);
    }

    close(): void {
        console.log("Closing client in port", this.port);
    }
    
};

export { WSClient };
