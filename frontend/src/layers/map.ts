import { Layer } from "../core/layer";
import { ECS, Entity, Sprite, Transform } from "../core/ecs/core/ecs";
import { TransformComponent } from "../core/ecs/components/transform";

import { Vec2 } from "../utils/math";

import { Application } from "pixi.js";
import { Container, filters } from "pixi.js";

import levelMapFile from "../assets/level_map.json";
import { SpriteComponent } from "../core/ecs/components/sprite";
import { LobbyLevelContext } from "../levels/lobby";
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

    private levelContext: LobbyLevelContext;

    constructor(ecs: ECS, levelContext: LobbyLevelContext, app: Application, resource: Record<string, any>) {
        super("TesteLayer", ecs);

        this.app = app;
        this.res = resource;
        this.levelContext = levelContext;

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
                    const sprite = entity.addComponent[Sprite]() as SpriteComponent;
                    sprite.setCutImg(
                        this.app.loader.resources["dungeon"],
                        (((currentSheet - 1) % 10) * 16),
                        (Math.floor((currentSheet - 1) / 10) * 16),
                        16, 16
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
        this.loadMap()

        this.dim.x = this.mapContainer.width;
        this.dim.y = this.mapContainer.height;

        // Apply a ligth blur on the soil
        this.mapContainer.filters = [ new filters.BlurFilter(1, 8) ];

        // Add layers to render stage
        this.app.stage.addChild(this.mapContainer);
    }

    onUpdate(deltaTime: number) {
        let fixFactorX = (this.dim.x - (this.dim.x * (1 - this.levelContext.zoom))) / 2.0;
        let fixFactorY = (this.dim.y - (this.dim.y * (1 - this.levelContext.zoom))) / 2.0;
        // Translate and scale soil
        this.mapContainer.x = this.levelContext.offsetX + fixFactorX;
        this.mapContainer.y = this.levelContext.offsetY + fixFactorY;
        this.mapContainer.scale.x = 1 - this.levelContext.zoom;
        this.mapContainer.scale.y = 1 - this.levelContext.zoom;
    }

    onDetach() {
        this.self.destroy();
    }
}

export { MapLayer };
