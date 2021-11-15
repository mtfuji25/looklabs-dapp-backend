// Level imports
import { Level } from "../Core/Level";
import { AwaitLevel } from "./Await";

class DefaultLevel extends Level {

    onStart(): void {
        this.context.engine.loadLevel(
            new AwaitLevel(this.context, "Awaiting")
        );
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
};

export { DefaultLevel };