import { Level } from "../Core/Level";

// Levels imports
import { AwaitingLevel } from "./Await";

class DefaultLevel extends Level {

    onStart(): void {
        this.context.engine.loadLevel(
            new AwaitingLevel(this.context, "Awaiting")
        );
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
};

export { DefaultLevel };