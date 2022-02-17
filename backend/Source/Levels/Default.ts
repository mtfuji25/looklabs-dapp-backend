// Level imports
import { Level } from "../Core/Level";

// Await level import
import { AwaitLevel } from "./Await";

//
// Default level, automatically loaded by engine on start up 
//

class DefaultLevel extends Level {

    // Just redirect the flow to Await Level
    onStart(): void {
        this.context.engine.loadLevel(
            new AwaitLevel(this.context, "Awaiting")
        );
    }

    onUpdate(deltaTime: number) {}

    onClose(): void {}
    
};

export { DefaultLevel };