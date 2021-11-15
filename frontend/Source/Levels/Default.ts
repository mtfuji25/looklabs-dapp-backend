import { Level } from "../Core/Level";

// Levels imports
import { ResultsLevel } from "./Results";

class DefaultLevel extends Level {

    onStart(): void {
        this.context.engine.loadLevel(
            new ResultsLevel(this.context, "Awaiting")
        );
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
};

export { DefaultLevel };