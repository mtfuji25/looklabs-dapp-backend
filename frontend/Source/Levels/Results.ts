import { Level } from "../Core/Level";

// Layers imports
import { WinnerLayer } from "../Layers/Results/Winner";
import { ResultsLayer } from "../Layers/Results/Results";
import { BattleStatusLayer } from "../Layers/Results/BattleStatus";

const BLACK_BG_COLOR = 0x000;

class ResultsLevel extends Level {
    onStart(): void {
        this.context.app.renderer.backgroundColor = BLACK_BG_COLOR;
        this.connectLayers();
    }

    connectLayers(): void {
        this.layerStack.pushLayer(
            new BattleStatusLayer(this.ecs, this.context.app)
        );
        // this.layerStack.pushLayer(
        //     new ResultsLayer(this.ecs, this.context.app)
        // );
        this.layerStack.pushLayer(
            new WinnerLayer(this.ecs, this.context.app)
        );
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
}

export { ResultsLevel };