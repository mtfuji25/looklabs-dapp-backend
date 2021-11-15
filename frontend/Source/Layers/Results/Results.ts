import { Layer } from "../../Core/Layer";

// Ecs and Components imports
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

class ResultsLayer extends Layer {
    // Current app instance
    private app: Application;

    // Results title entity
    private title: Text;

    private readonly titleStyle: Partial<ITextStyle> = {
        fontFamily: "monospace",
        fontStyle: "normal",
        fontWeight: "bold",
        fontSize: 24,
        fill: 0xffffff,
        lineHeight: 31,
        align: "center"
    };

    // Percents of the screen
    private percentX: number;
    private percentY: number;

    constructor(ecs: ECS, app: Application) {
        super("TesteLayer", ecs);

        this.app = app;

        // Set current percents
        this.percentX = this.app.view.width / 100.0;
        this.percentY = this.app.view.height / 100.0;

        // Create results title
        const title = this.ecs.createEntity(
            58.4022 * this.percentX,
            5.25 * this.percentY
        ).addText("RESULTS", this.titleStyle);

        this.title.addStage(this.app);
    }

    onAttach() {}

    onUpdate(deltaTime: number) {}

    onDetach() {
        this.self.destroy();
    }
}

export { ResultsLayer };