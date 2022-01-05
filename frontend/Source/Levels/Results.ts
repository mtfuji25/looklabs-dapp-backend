import { Level } from "../Core/Level";
import { v4 as uuidv4 } from "uuid";

// Layers imports
import { WinnerLayer } from "../Layers/Results/Winner";
import { ResultsLayer } from "../Layers/Results/Results";
import { BattleStatusLayer } from "../Layers/Results/BattleStatus";
import { DefaultLevel } from "./Default";
import { PlayerLayer } from "../Layers/Lobby/Player";
import { PlayerNames } from "../Clients/Interfaces";

const BLACK_BG_COLOR = 0x000;

class ResultsLevel extends Level {

    private counter: number = 0.0;

    async onStart(): Promise<void> {
        this.context.app.renderer.backgroundColor = BLACK_BG_COLOR;
        
        await this.context.ws.whenReady();

        const response = await this.context.ws.request(
            {
                uuid: uuidv4(),
                type: "request",
                content: {
                    type: "player-names"
                }
            }
        );

        PlayerLayer.lastGamePlayerNames = {};

        const content = response.content as PlayerNames;

        Object.keys(content.names).map((key) => {
            PlayerLayer.lastGamePlayerNames[key] = content.names[key];
        })

        const participants = await this.context.strapi.getGameParticipants(this.props.gameId);

        const splitId = (participants[0].nft_id).split('/')[1];
        const address = (participants[0].nft_id).split('/')[0];

        const winnerDetails = await this.context.strapi.getParticipantDetails(address, splitId);

        this.layerStack.pushLayer(
            new ResultsLayer(this.ecs, this.context.app, participants)
        );

        this.layerStack.pushLayer(
            new BattleStatusLayer(this.ecs, this.context.app)
        );

        this.layerStack.pushLayer(
            new WinnerLayer(this.ecs, this.context.app, participants[0], winnerDetails)
        );
    }

    onUpdate(deltaTime: number) {
        // after 300 seconds (5 minutes) load default level
        if(this.counter >= 300.0) {
            this.context.engine.loadLevel(new DefaultLevel(
                this.context, "Default"
            ))
        }
        this.counter += deltaTime;
    }

    onClose(): void {}
}

export { ResultsLevel };
