import { Level } from "../Core/Level";

// Layers imports
import { WinnerLayer } from "../Layers/Results/Winner";
import { ResultsLayer } from "../Layers/Results/Results";
import { BattleStatusLayer } from "../Layers/Results/BattleStatus";
import { DefaultLevel } from "./Default";

const BLACK_BG_COLOR = 0x000;

class ResultsLevel extends Level {

    private readonly initialDate: number = Date.now();

    onStart(): void {
        this.context.app.renderer.backgroundColor = BLACK_BG_COLOR;
        this.connectLayers();
    }

    connectLayers(): void {
        const responseParticipant = this.props.responseParticipant;
        const responseWinner = this.props.responseWinner;

        if (responseParticipant === null || responseWinner == null) {
            this.context.strapi.getGameParticipants(this.props.gameId).then((participants) => {
                let splitId = (participants[0].nft_id).split('/')[1];
                if(splitId > 50) splitId -= 50;
                if(splitId == 0) splitId += 1;
    
                this.layerStack.pushLayer(
                    new ResultsLayer(this.ecs, this.context.app, participants)
                );   
                this.layerStack.pushLayer(
                    new BattleStatusLayer(this.ecs, this.context.app)
                );
                this.context.strapi.getParticipantDetails(splitId).then((participant) => {
                    this.layerStack.pushLayer(
                        new WinnerLayer(this.ecs, this.context.app, participants[0], participant)
                    );
                })
            })
        } else {
            let splitId = (responseParticipant[0].nft_id).split('/')[1];
            if(splitId > 50) splitId -= 50;
            if(splitId == 0) splitId += 1;
            this.layerStack.pushLayer(
                new ResultsLayer(this.ecs, this.context.app, responseParticipant)
            );   
            this.layerStack.pushLayer(
                new BattleStatusLayer(this.ecs, this.context.app)
            );
            this.layerStack.pushLayer(
                new WinnerLayer(this.ecs, this.context.app, responseParticipant[0], responseWinner)
            );
        }
    }

    onUpdate(deltaTime: number) {
        // after 300 seconds (5 minutes) load default level
        if(Date.now() - this.initialDate >= (300 * 1000)) {
            this.context.engine.loadLevel(new DefaultLevel(
                this.context, "Default"
            ))
        }
    }

    onClose(): void {
        this.layerStack.destroy();
    }
}

export { ResultsLevel };
