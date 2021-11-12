import { Level } from "../core/level";
import { AwaitingLevel } from "./awaiting";


class DefaultLevel extends Level {

    onStart(): void {
        //
        //  Put load logic
        //

        this.context.engine.loadLevel(new AwaitingLevel(this.context, "Awaiting"));
    }

    onUpdate(deltaTime: number) {
        
    }

    onClose(): void {}
};

export { DefaultLevel };