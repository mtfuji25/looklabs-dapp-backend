import { ScheduledGameParticipant } from "../clients/strapi";
import { GridComponent } from "../core/ecs/components/grid";
import { Grid } from "../core/ecs/core/ecs";
import { EngineContext } from "../core/interfaces";
import { Level } from "../core/level";
import { MapColliderLayer } from "../layers/mapcollider";
import { PlayerLayer } from "../layers/player";
import { AwaitLevel } from "./await";

class LobbyLevel extends Level {

    private gameId: number;
    private ready: boolean = false;
    private participants: ScheduledGameParticipant[] = [];
    private fighters: PlayerLayer[] = [];

    constructor(context: EngineContext, name: string, gameId: number) {
        super(context, name);

        this.gameId = gameId;
    }

    onStart(): void {
        this.context.strapiClient.getGameById(this.gameId)
            .then((game) => {
                game.scheduled_game_participants.map((participant) => {
                    this.participants.push(participant);
                })
                this.startGame();
            }).catch((err) => {
                console.log(err);
                this.context.closeRequest = true;
            });
    }

    startGame() {
        const mapCollider = new MapColliderLayer(this.ecs);
        const grid = mapCollider.getSelf().getComponent[Grid]() as GridComponent;

        this.layerStack.pushLayer(mapCollider);

        this.participants.map((participant) => {
            const player = new PlayerLayer(
                this.ecs,
                this.context.wsClient,
                participant.id, grid,
                (player) => {
                    for (let i = this.fighters.length - 1; i > 0; --i) {
                        const j = Math.floor(Math.random() * (i + 1));
                        [ this.fighters[i], this.fighters[j] ] = [ this.fighters[j], this.fighters[i] ]
                    }

                    let prey: PlayerLayer | null = null;
                    for (let fighter of this.fighters) {
                        if (fighter === player)
                            continue;

                        if (fighter.hunted)
                            continue;

                        prey = fighter;
                        fighter.hunted = true;
                        break;
                    }

                    if (!prey) {
                        for (let fighter of this.fighters) {
                            if (fighter === player)
                                continue;

                            prey = fighter;
                            break;
                        }
                    }

                    return prey?.getSelf() ?? null;
                }
            );

            grid.addDynamic(player.getSelf());

            player.setOnDie((data) => {
                // Removes dead player from update cycle
                this.layerStack.popLayer(data);

                // Removes dead player from fighters
                this.fighters = this.fighters.filter(item => item !== data);
                // this.context.strapiClient.createParticipantResult({
                //     scheduled_game_participant: data.playerID,
                //     result: "died"
                // }).catch((err) => {
                //     console.log("Failed to store results in player: ", data.playerID);
                // })
            });

            this.fighters.push(player);
            this.layerStack.pushLayer(player);
        });

        this.ready = true;
    }

    onUpdate(deltaTime: number) {
        if (this.fighters.length <= 1 && this.ready) {
            this.context.engine.loadLevel(new AwaitLevel(this.context, "Await"));
        }
    }

    onClose(): void {

    }
};

export { LobbyLevel };