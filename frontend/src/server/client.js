
const initClient = (msgQueue) => {
    let ws = new WebSocket("ws:localhost:8082");

    console.log("Connected to backend");

    ws.addEventListener("open", (e) => {
        ws.addEventListener("message", (msg) => {
            console.log(msg)
        })
        ws.send(JSON.stringify({
            type: "request",
            content: "layer0"
        }))
    })

    ws.addEventListener("message", msg => {
        console.log(msg);
    });
}

export { initClient }