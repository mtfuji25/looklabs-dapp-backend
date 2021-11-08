
const listeners = [];
let connection;

const WS = {

    connected: false,

    request(msg) {
        if (WS.connected)
            connection.send(JSON.stringify(msg));
    },

    addListener(listener) {
        listeners.push(listener);
        return {
            id: listeners.length - 1,
            body: listener
        }
    },

    removeListener(listener) {
        listeners.slice(listener.id, 1);
    }
}

const dispatchMsgs = (msg) => {
    let data = JSON.parse(msg.data);
    console.log("New message from server:");
    console.log(data);
    listeners.forEach(listener => {
        listener.onServerMsg(data);
    })
}

const initClient = () => {
    connection = new WebSocket("ws:localhost:8082");

    connection.addEventListener("open", e => {
        console.log("Connected to backend.");
        WS.connected = true;

        connection.addEventListener("message", (message) => {
            dispatchMsgs(message);
        });
    });

    connection.addEventListener("close", e => {
        WS.connected = false;
        setTimeout(() => {
            console.log("Trying to reconnect...");
            initClient();
        }, 1000);
    });
}

export { initClient, WS }