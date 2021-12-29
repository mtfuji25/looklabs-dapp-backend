import { Layer } from "../../Core/Layer";
import { v4 as uuidv4 } from "uuid";

// Pixi imports
import { Application, ITextStyle } from "pixi.js";

// Interfaces
import { EngineContext } from "../../Core/Interfaces";

// Ecs and Components
import { ECS } from "../../Core/Ecs/Core/Ecs";
import { Text } from "../../Core/Ecs/Components/Text";
import { GameStatus, requests } from "../../Clients/Interfaces";
import { LobbyLevel } from "../../Levels/Lobby";
import { AwaitLevel } from "../../Levels/Await";

class TextLayer extends Layer {
    private app: Application;
    private subtitle: Text;
    private percentX: number;
    private percentY: number;

    private screenX: number;
    private screenY: number;

    // Styles
    private readonly titleStyle: Partial<ITextStyle> = {
        fontFamily: "Space Mono",
        fontSize: "130px",
        fill: 0xffffff,
        align: "center",
        fontWeight: "700"
    };

    // count that resets every second
    private fiveSecCount: number = 0.0;

    constructor(ecs: ECS, app: Application) {
        super("TesteLayer", ecs);

        this.app = app;
        // sets percents
        this.percentX = this.app.view.width / 100.0;
        this.percentY = this.app.view.height / 100.0;

        this.screenX = this.app.view.width;
        this.screenY = this.app.view.height;
    }

    renderText(text: Text, y: number) {
        text.setPos(
            this.percentX * 50 - text.text.width / 2.0,
            this.percentY * y - text.text.height / 2.0
        );
        text.addStage(this.app);
    }

    onAttach() {
        this.subtitle = this.ecs.createEntity().addText("NEXT BATTLE SOON", this.titleStyle);

        this.renderText(this.subtitle, 50);
    }

    onUpdate(deltaTime: number) {
        if(this.app.view.width !== this.screenX || this.app.view.height !== this.screenY) {
            // resets percentages
            this.percentX = this.app.view.width / 100.0;
            this.percentY = this.app.view.height / 100.0;

            this.screenX = this.app.view.width;
            this.screenY = this.app.view.height;

            this.subtitle.setPos(
                this.percentX * 50 - this.subtitle.text.width / 2.0,
                this.percentY * 50 - this.subtitle.text.height / 2.0
            );
        }
    }

    onDetach() {
        this.self.destroy();
    }
}

export { TextLayer };
