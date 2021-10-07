const WebSocket = require("ws");
const fs = require("fs");

let resources;

// fs.readFile("./resources.json", "utf-8", (err, jsonString) => {
//     if (err) {
//         console.log(err);
//     } else {
//         try {
//             resources = JSON.parse(jsonString);
//         } catch (e) {
//             console.log("Error while parsing json", e);
//         }
//     }
// });

const wss = new WebSocket.Server({ port: 8082 });

let msgs = [];

wss.on("connection", ws => {
    console.log("New client connected");

    ws.on("message", message => {
        const data = JSON.parse(message.toString());
        console.log("Message")
    });
});

let start = Date.now();

const loop = () => {
    while (true) {
        let current = Date.now();
        let deltaTime = (current - start) / 1000.0;
        start = current;


    }
};

loop();

const UNIT_WIDTH = 32;
const UNIT_HEIGTH = 32;

class Rectangle {
    constructor(x, y, width, heigth) {
        this.width = width;
        this.heigth = heigth;

        this.center = {
            x: x,
            y: y
        };

        this.vel = {
            x: 0.0,
            y: 0.0
        }

        this.corners = {
            lu: {
                x: x - (width / 2),
                y: y - (heigth / 2)
            },
            ld: {
                x: x - (width / 2),
                y: y + (heigth / 2)
            },
            ru: {
                x: x + (width / 2),
                y: y - (heigth / 2)
            },
            rd: {
                x: x + (width / 2),
                y: y + (heigth / 2)
            }
        };
    }
};

const rayIntersectRec = (rayOrigin, rayDir, recTarget, results) => {
    let lu = recTarget.corners.lu;
    let rd = recTarget.corners.rd;

    const tNear = {
        x: (lu.x - rayOrigin.x) / rayDir.x, 
        y: (lu.y - rayOrigin.y) / rayDir.y
    };

    if (tNear.x == NaN || tNear.x == Infinity || tNear.x == -Infinity
        ||
        tNear.y == NaN || tNear.y == Infinity || tNear.y == -Infinity) return false;

    const tFar = {
        x: (rd.x - rayOrigin.x) / rayDir.x, 
        y: (rd.y - rayOrigin.y) / rayDir.y
    };

    if (tFar.x == NaN || tFar.x == Infinity || tFar.x == -Infinity
        ||
        tFar.y == NaN || tFar.y == Infinity || tFar.y == -Infinity) return false; 

    if (tNear.x > tFar.x)
        [ tNear.x, tFar.x ] = [ tFar.x, tNear.x ];
    if (tNear.y > tFar.y)
        [ tNear.y, tFar.y ] = [ tFar.y, tNear.y ];

    if (tNear.x > tFar.y || tNear.y > tFar.x)
        return false;

    const tHitNear = Math.max(tNear.x, tNear.y);
    const tHitFar = Math.min(tFar.x, tFar.y);

    if (tHitFar < 0)
        return false;

    let hitPoint = {
        x: rayOrigin.x + tHitNear * rayDir.x,
        y: rayOrigin.y + tHitNear * rayDir.y
    };

    let hitNormal = {
        x: 0,
        y: 0
    };

    if (tNear.x > tNear.y) {
        if (rayDir.x < 0) {
            hitNormal.x = 1;
            hitNormal.y = 0;
        } else {
            hitNormal.x = -1;
            hitNormal.y = 0;
        }
    } else if (tNear.x < tNear.y) {
        if (rayDir.y < 0) {
            hitNormal.x = 0;
            hitNormal.y = 1;
        } else {
            hitNormal.x = 0;
            hitNormal.y = -1;
        }
    }
        
    results.cp = hitPoint;
    results.cn = hitNormal;
    results.t = tHitNear;

    return true;            
}

const recIntersectRec = (a, b, deltaTime, res) => {
    if (a.vel.x == 0 && a.vel.y == 0)
        return false;

    let expanded = new Rectangle(b.center.x, b.center.y, b.width + a.width, b.heigth + a.heigth);

    if (rayIntersectRec(a.center, { x: a.vel.x * deltaTime, y: a.vel.y * deltaTime }, expanded, res)) {
        if (res.t >= 0.0 && res.t < 1.0)
            return true;
    }

    return false;
}

const wordToView = (pos, props) => {
    return {
        x: (pos.x * props.width + props.width) / 2.0,
        y: props.height - (pos.y * props.height + props.height) / 2.0
    }
}

const viewToWord = (pos, props) => {
    return {
        x: (pos.x / props.width * 2.0) - 1.0,
        y: ((props.height - pos.y) / props.height * 2.0) - 1.0
    }
}

const resToNdc = (res, props) => {
    return {
        x: (res.x / props.width) * 2.0,
        y: (res.y / props.height) * 2.0
    }
}

const ndcToRes = (ndc, props) => {
    return {
        x: (ndc.x * props.width) / 2.0,
        y: (ndc.y * props.height) / 2.0
    }
}