import { Level } from "../Core/Level";

// Layers imports
import { WinnerLayer } from "../Layers/Results/Winner";
import { ResultsLayer } from "../Layers/Results/Results";
import { BattleStatusLayer } from "../Layers/Results/BattleStatus";
import { DefaultLevel } from "./Default";

const BLACK_BG_COLOR = 0x000;

class ResultsLevel extends Level {

    private counter: number = 0.0;

    onStart(): void {
        this.context.app.renderer.backgroundColor = BLACK_BG_COLOR;
        this.connectLayers();
    }

    connectLayers(): void {
        const responseParticipant = this.props.responseParticipant;
        const responseWinner = this.props.responseWinner;

        if (/*responseParticipant === null || responseWinner == null*/ true) {
            this.context.strapi.getGameParticipants(this.props.gameId).then((participants) => {
                let splitId = (participants[0].nft_id).split('/')[1];
                let address = (participants[0].nft_id).split('/')[0];
                if(splitId > 50) splitId -= 50;
                if(splitId == 0) splitId += 1;
    
                this.layerStack.pushLayer(
                    new ResultsLayer(this.ecs, this.context.app, participants)
                );   
                this.layerStack.pushLayer(
                    new BattleStatusLayer(this.ecs, this.context.app)
                );
                this.context.strapi.getParticipantDetails(address, splitId).then((participant) => {
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
        if(this.counter >= 300.0) {
            this.context.engine.loadLevel(new DefaultLevel(
                this.context, "Default"
            ))
        }
        this.counter += deltaTime;
    }

    onClose(): void {
        this.layerStack.destroy();
    }
}

export { ResultsLevel };
