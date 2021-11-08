"use strict";
// import { WebSocket } from "ws";
// import { WSClient } from "../clients/websocket";
// import { RigidbodyComponent } from "../core/ecs/components/rigidbody";
// import { TransformComponent } from "../core/ecs/components/transform";
// import { ECS, Entity, Grid, Rectangle, Rigidbody, Transform } from "../core/ecs/core/ecs";
// import { Layer } from "../core/layer";
// import { MainLevelContext } from "../levels/mainlevel";
// class TesteLayer extends Layer {
//     // Current ecs instance
//     private ecs: ECS;
//     private wsClient: WSClient;
//     private levelContext: MainLevelContext;
//     ent1: Entity;
//     ent2: Entity;
//     ent3: Entity;
//     ent4: Entity;
//     constructor(ecs: ECS, wsClient: WSClient, levelContext: MainLevelContext) {
//         super("TesteLayer");
//         this.ecs = ecs;
//         this.wsClient = wsClient;
//         this.levelContext = levelContext;
//         this.ent1 = this.ecs.createEntity(0.5, 0.0);
//         this.ent2 = this.ecs.createEntity(0.0, 0.0);
//         this.ent3 = this.ecs.createEntity(0.0, 0.5);
//         this.ent4 = this.ecs.createEntity(0.0, -0.5);
//         this.levelContext.grid?.addDynamic(this.ent1);
//         this.levelContext.grid?.addDynamic(this.ent2);
//         //this.levelContext.grid?.addDynamic(this.ent3);
//         //this.levelContext.grid?.addDynamic(this.ent4);
//         wsClient.addConListener((con) => this.onConnection(con));
//     }
//     onConnection(ws: WebSocket): boolean {
//         console.log("Hei alguem conectou");
//         const pos1 = this.ent1.getComponent[Transform]() as TransformComponent;
//         const pos2 = this.ent2.getComponent[Transform]() as TransformComponent;
//         const pos3 = this.ent3.getComponent[Transform]() as TransformComponent;
//         const pos4 = this.ent4.getComponent[Transform]() as TransformComponent;
//         this.wsClient.broadcast({ type: "create-enemy", content: {id: 0, pos: { x: pos1.pos.x, y: pos1.pos.y } } })
//         this.wsClient.broadcast({ type: "create-enemy", content: {id: 1, pos: { x: pos2.pos.x, y: pos2.pos.y } } })
//         //this.wsClient.broadcast({ type: "create-enemy", content: {id: 2, pos: { x: pos3.pos.x, y: pos3.pos.y } } })
//         //this.wsClient.broadcast({ type: "create-enemy", content: {id: 3, pos: { x: pos4.pos.x, y: pos4.pos.y } } })
//         return false;
//     }
//     onAttach() {
//         const width = this.levelContext.grid?.intervalX;
//         const height = this.levelContext.grid?.intervalY;
//         this.ent1.addComponent[Rectangle](width, height);
//         this.ent2.addComponent[Rectangle](width, height);
//         this.ent3.addComponent[Rectangle](width, height);
//         this.ent4.addComponent[Rectangle](width, height);
//         const rg1 = this.ent1.addComponent[Rigidbody]() as RigidbodyComponent;
//         const rg2 = this.ent2.addComponent[Rigidbody]() as RigidbodyComponent;
//         const rg3 = this.ent3.addComponent[Rigidbody]() as RigidbodyComponent;
//         const rg4 = this.ent4.addComponent[Rigidbody]() as RigidbodyComponent;
//         rg1.velocity.x = -0.04;
//         rg1.velocity.y =  0.03;
//         rg2.velocity.x =  0.03;
//         rg2.velocity.y =  0.03;
//         rg3.velocity.y = -0.05;
//         rg3.velocity.y =  0.02;
//         rg4.velocity.x =  0.03;
//         rg4.velocity.y =  0.02;
//     }
//     onUpdate(deltaTime: number) {
//         const pos1 = this.ent1.getComponent[Transform]() as TransformComponent;
//         const pos2 = this.ent2.getComponent[Transform]() as TransformComponent;
//         const pos3 = this.ent3.getComponent[Transform]() as TransformComponent;
//         const pos4 = this.ent4.getComponent[Transform]() as TransformComponent;
//         this.wsClient.broadcast({ type: "update-enemy", content: { id: 0, action: 4,  pos: { x: pos1.pos.x, y: pos1.pos.y } } })
//         this.wsClient.broadcast({ type: "update-enemy", content: { id: 1, action: 4,  pos: { x: pos2.pos.x, y: pos2.pos.y } } })
//         //this.wsClient.broadcast({ type: "update-enemy", content: { id: 2, action: 4,  pos: { x: pos3.pos.x, y: pos3.pos.y } } })
//         //this.wsClient.broadcast({ type: "update-enemy", content: { id: 3, action: 4,  pos: { x: pos4.pos.x, y: pos4.pos.y } } })
//     }
//     onDetach() {
//         console.log("layer desconectada");
//     }
// }
// export { TesteLayer };
