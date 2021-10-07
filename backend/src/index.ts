import * as WebSocket from "ws";
import * as fs from "fs";

let resources: any;

fs.readFile("./src/resources.json", "utf-8", (err, jsonString) => {
    if (err) {
        console.log(err);
    } else {
        try {
            resources = JSON.parse(jsonString);
        } catch (e) {
            console.log("Error while parsing json", e);
        }
    }
});

const wss = new WebSocket.Server({ port: 8082 });

let msgs: any = [];

wss.on("connection", ws => {
    console.log("New client connected");

    ws.on("message", message => {
        const data = JSON.parse(message.toString());
        console.log("Message")
        msgs.push({
            client: ws,
            type: data.type,
            content: data.content
        });
    });
});

const processMsgs = () => {
    msgs.forEach((element: any) => {
        console.log(element);
    });
}

let running = true;

const gameLoop = () => {
    
}

gameLoop();