
let fns = [];

const dispatchFns = (msg) => {
    let data = JSON.parse(msg.data);
    console.log(data);
    fns.forEach(fn => {
        fn.onServerMsg(data);
    })
}

const addServerListener = (callback) => {
    fns.push(callback);
};

const initClient = () => {
    let ws = new WebSocket("ws:localhost:8082");
    ws.addEventListener("open", (e) => {
        console.log("Connected to backend");
        ws.addEventListener("message", (msg) => {
            dispatchFns(msg);
        });
        ws.send(JSON.stringify({
            hey: 23
        }));
    });
}

export { initClient, addServerListener }