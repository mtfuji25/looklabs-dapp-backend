import { Level } from "../core/level";
import { AwaitLevel } from "./await";

class DefaultLevel extends Level {

    onStart(): void {
        this.context.engine.loadLevel(new AwaitLevel(this.context, "Await"));
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
};

export { DefaultLevel };