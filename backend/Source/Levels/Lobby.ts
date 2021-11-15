// // Level imports
// import { Level } from "../Core/Level";
// import { AwaitLevel } from "./Await";

// // Web clients imports
// import { ScheduledGameParticipant } from "../Clients/Strapi";

// // Interfaces imports
// import { EngineContext } from "../Core/Interfaces";

// // Layers import
// import { PlayerLayer } from "../Layers/";
// import { MapColliderLayer } from "../Layers";

// class LobbyLevel extends Level {

//     // Current running game id
//     private gameId: number;

//     // Current game participants
//     private participants: ScheduledGameParticipant[] = [];

//     private ready: boolean = false;
//     private fighters: PlayerLayer[] = [];

//     constructor(context: EngineContext, name: string, gameId: number) {
//         super(context, name);

//         this.gameId = gameId;
//     }

//     onStart(): void {
//         this.context.strapiClient.getGameById(this.gameId)
//             .then((game) => {
//                 game.scheduled_game_participants.map((participant) => {
//                     this.participants.push(participant);
//                 })
//                 this.startGame();
//             }).catch((err) => {
//                 console.log(err);
//                 this.context.closeRequest = true;
//             });
//     }

//     startGame() {
//         const mapCollider = new MapColliderLayer(this.ecs);
//         const grid = mapCollider.getSelf().getComponent[Grid]() as GridComponent;

//         this.layerStack.pushLayer(mapCollider);

//         this.participants.map((participant) => {
//             const player = new PlayerLayer(
//                 this.ecs,
//                 this.context.wsClient,
//                 participant.id, grid,
//                 (player) => {
//                     for (let i = this.fighters.length - 1; i > 0; --i) {
//                         const j = Math.floor(Math.random() * (i + 1));
//                         [ this.fighters[i], this.fighters[j] ] = [ this.fighters[j], this.fighters[i] ]
//                     }

//                     let prey: PlayerLayer | null = null;
//                     for (let fighter of this.fighters) {
//                         if (fighter === player)
//                             continue;

//                         if (fighter.hunted)
//                             continue;

//                         prey = fighter;
//                         fighter.hunted = true;
//                         break;
//                     }

//                     if (!prey) {
//                         for (let fighter of this.fighters) {
//                             if (fighter === player)
//                                 continue;

//                             prey = fighter;
//                             break;
//                         }
//                     }

//                     return prey?.getSelf() ?? null;
//                 }
//             );

//             grid.addDynamic(player.getSelf());

//             player.setOnDie((data) => {
//                 // Removes dead player from update cycle
//                 this.layerStack.popLayer(data);

//                 // Removes dead player from fighters
//                 this.fighters = this.fighters.filter(item => item !== data);
//                 // this.context.strapiClient.createParticipantResult({
//                 //     scheduled_game_participant: data.playerID,
//                 //     result: "died"
//                 // }).catch((err) => {
//                 //     console.log("Failed to store results in player: ", data.playerID);
//                 // })
//             });

//             this.fighters.push(player);
//             this.layerStack.pushLayer(player);
//         });

//         this.ready = true;
//     }

//     onUpdate(deltaTime: number) {
//         if (this.fighters.length <= 1 && this.ready) {
//             this.context.engine.loadLevel(new AwaitLevel(this.context, "Await"));
//         }
//     }

//     onClose(): void {

//     }
// };

// export { LobbyLevel };