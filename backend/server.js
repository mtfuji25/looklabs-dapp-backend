const WebSocket = require("ws");
const fs = require("fs");

//
//  *** Utils sector ***  
//

const sleep = (ms) => {
    return new Promise(resolve => setTimeout(resolve, ms));
};


const wss = new WebSocket.Server({ port: 8082 });

let msgs = [];

initial_positions = [
  { x:  0.3, y: -0.1},
  { x:  0.0, y: -0.2},
  { x: -0.3, y: 0.3},
//  { x: 3.5, y: 3.5},
  ]

enemies = [];
aggroed_by = []; // first index is the id 0 is being aggroed by those elements

const aggro = (enemy) => {
  // lets aggro it to somebody
  if (enemies.length >= 2) {
    let id = 0;
    console.log('for');
    for (let i = 0; i != aggroed_by.length; ++i) {
      if (i != enemy.id) { // can't aggro to itself
      console.log('for i ', i);
      let array = aggroed_by[i];
      console.log('array is', array);
      if (array.length > 1) {
        const pair = enemies[a.pop()];
        enemies.at(-1).aggro = pair.id;
        pair.aggro = enemy.id;
        aggroed_by.push([pair.id]);
        console.log('aggroing ', enemy.id, ' with ', pair.id);
      }
      else if (array.length == 0 && enemies[i].health > 0) {
        const pair = enemies[i];
        enemy.aggro = i;
        pair.aggro = enemy.id;
        aggroed_by.push([pair.id]);
        console.log('aggroing ', enemy.id, ' with ', pair.id);
      }
    }
    }
  }
};

wss.on("connection", ws => {
    console.log("New client connected");
    if (enemies.length >= initial_positions.length)
      return;
    enemies.push({ id: enemies.length, pos: initial_positions[enemies.length], health: 100});
  let cur_e = enemies.at(-1);
  
  aggro(cur_e);
  if (cur_e.aggro == undefined)
    aggroed_by.push([]);

    console.log("New enemy ", enemies.at(-1));

    wss.clients.forEach(client => {
      msg = JSON.stringify({ type: "create-enemy", content: enemies.at(-1)});
      console.log('sent', msg);
      client.send(msg);
      //client.send(JSON.stringify({ type: "update-enemy", content: { id: 0, action: 4,  pos: { x: 0.5, y: 0.0 } } }));
    });
    for (let e of enemies) {
      if (enemies.id != enemies.length-1) {
        msg = JSON.stringify({ type: "create-enemy", content: e});
        console.log(msg);
        ws.send(msg);
      }
    }
    ws.on("message", async (message) => {
        const data = JSON.parse(message.toString());
        console.log("Message")
    });
});

let start = Date.now();

const loop = async () => {
    while (true) {
        let current = Date.now();
        let deltaTime = (current - start) / 1000.0;
        start = current;
      let survivors = 0;
      let last_survivor = 0;

      for (let e of enemies) {
        if (e.health > 0) {
          survivors++;
          last_survivor = e.id;
        if (e.aggro != undefined) {
          let other = enemies[e.aggro];
          let dir = [other.pos.x - e.pos.x, other.pos.y - e.pos.y];
          let mag = Math.sqrt(dir[0]*dir[0] + dir[1]*dir[1]);
          //console.log('mag ', mag, ' the ', e.id, ' is aggroed to ', e.aggro);

          if (mag > 0.02) {
            let norm_dir = [dir[0]/mag, dir[1]/mag];
            e.pos.x += norm_dir[0]/200;
            e.pos.y += norm_dir[1]/200;
            //console.log('moved by ', norm_dir[0]/100, ',', norm_dir[1]/100);
          }
          else
          {
            //console.log('already close to what I want to hit');
            //hit();
            hit = Math.random() * 10 /* 10 is maximum hit */;
            if (other.health <= hit)
            {
              other.health = 0;
              // opponent is dead, unaggro and then aggroes to somebody else
              aggroed_by[e.id].splice(aggroed_by[e.id].indexOf(other.id), 1);
              aggroed_by[other.id].splice(aggroed_by[other.id].indexOf(other.aggro), 1);
              delete other.aggro;
              delete e.aggro;
              aggro(e);
              console.log('killed');
            }
            else
            {
              other.health -= hit;
              console.log('hit ', hit, ' opponent health', other.health);
            }
          }
        }
        }
      }
      if (survivors == 1 && enemies.length >= 2) {
        console.log('Winner is', last_survivor);
      }
        wss.clients.forEach(client => {
          for (let e of enemies) {
            msg = JSON.stringify({ type: "update-enemy", content: { id: e.id, action: 4,  pos: e.pos } });
            //console.log(msg);
            client.send(msg);
          }
        });

        await sleep(1000/5); // 10fps
    }
}

loop();

//
//  *** Rectangle and collision sector ***
//

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


//
//  *** Protocol description ***
//

/*
*   Enemy msgs protocol - All position should be sent using NDC
*
*   { type: "create-enemy", content: { id: ..., pos: { x: ..., y: ... } } }
*
*   { type: "update-enemy", content: { id: ..., action: ..., pos: { x: ..., y: ... } } }
*
*   { type: "delete-enemy", content: { id: ... } }
*/
