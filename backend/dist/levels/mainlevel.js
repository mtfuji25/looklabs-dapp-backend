"use strict";
// import { GridComponent } from "../core/ecs/components/grid";
// import { Level } from "../core/level";
// import { MapColliderLayer } from "../layers/mapcollider";
// import { TesteLayer } from "../layers/test";
// interface MainLevelContext {
//     grid: GridComponent | null;
// };
// class MainLevel extends Level {
//     private levelContext: MainLevelContext = {
//         grid: null,
//     }
//     onStart(): void {
//         console.log("Main Level connected");
//         this.layerStack.pushLayer(new MapColliderLayer(this.ecs, this.levelContext));
//         this.layerStack.pushLayer(new TesteLayer(this.ecs, this.context.wsClient, this.levelContext));
//         this.context.strapiClient.addMsgListener((message) => {
//             console.log("Mensagem recebida no level");
//             console.log(message);
//             this.context.strapiClient.createParticipantResult({
//                 scheduled_game_participant: message.scheduled_game_participants[0].id,
//                 result: "died"
//             }).catch((err) => {
//                 console.log(err)
//             })
//             return false;
//         })
//     }
//     onUpdate(deltaTime: number) {
//     }
//     onClose(): void {
//         console.log("Main Level disconnected");
//     }
// };
// export { MainLevel, MainLevelContext };
