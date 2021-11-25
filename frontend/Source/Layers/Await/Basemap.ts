// Layer imports
import { Layer } from "../../Core/Layer";

import { ECS, Entity } from "../../Core/Ecs/Core/Ecs";

// Math imports
import { Vec2 } from "../../Utils/Math";

// Pixi imports
import { Application, Container, filters } from "pixi.js";
import { ColorOverlayFilter } from 'pixi-filters';

import levelMapFile from "../../Assets/AwaitLevelMap.json";
// Cast to something that typescript can understand
const levelMap: Record<string, any> = levelMapFile;

class MapLayer extends Layer {
    // Entities storage
    protected entities: Entity[] = [];

    // Map container
    protected mapContainer: Container;

    // Container dim
    protected dim: Vec2 = new Vec2();

    protected app: Application;
    protected res: Record<string, any>;

    constructor(ecs: ECS, app: Application, resource: Record<string, any>) {
        super("TesteLayer", ecs);

        this.app = app;
        this.res = resource;

        this.mapContainer = new Container();
    }

    loadMap() {
        let rows = levelMap["height"];
        let cols = levelMap["width"];

        let x = 0.0;
        let y = 0.0;

        for (let i = 0; i < rows; ++i) {
            y += 8;
            for (let j = 0; j < cols; ++j) {
                x += 8;
                const currentSheet = levelMap["data"][i][j];
                if (currentSheet !== 0) {
                    const entity = this.ecs.createEntity(x, y);
                    const sprite = entity.addSprite();
                    sprite.setCutImg(
                        this.app.loader.resources["dungeon"],
                        ((currentSheet - 1) % 10) * 16,
                        Math.floor((currentSheet - 1) / 10) * 16,
                        16,
                        16
                    );

                    this.entities.push(entity);
                    this.mapContainer.addChild(sprite.sprite);
                }
                x += 8;
            }
            x = 0;
            y += 8;
        }
    }

    onAttach() {
        this.loadMap();

        // Apply a ligth blur on the soil
        this.mapContainer.filters = [new filters.BlurFilter(1, 8), new ColorOverlayFilter([0, 0, 0], 0.6)];

        const percentX = this.app.view.width / 100.0;
        const percentY = this.app.view.height / 100.0;

        this.dim.x = this.mapContainer.width;
        this.dim.y = this.mapContainer.height;

        this.mapContainer.x = 50 * percentX - this.dim.x / 2.0;
        this.mapContainer.y = 50 * percentY - this.dim.y / 2.0;

        // Add layers to render stage
        this.app.stage.addChild(this.mapContainer);
    }

    onUpdate(deltaTime: number) {}

    onDetach() {
        this.self.destroy();
        this.app.stage.removeChild(this.mapContainer);
    }
}

export { MapLayer };