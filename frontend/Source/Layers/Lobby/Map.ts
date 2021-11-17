// Layer import
import { Layer } from "../../Core/Layer";

// Constants
import { SPRITE_SIZE } from "../../Constants/Constants";

// Ecs imports
import { ECS, Entity } from "../../Core/Ecs/Core/Ecs";

// Pixi imports
import { Application, Container, filters } from "pixi.js";

// Lobby level context
import { LobbyLevelContext } from "../../Levels/Lobby";

// Files import
import levelMapFile from "../../Assets/LevelMap.json";
const levelMap: Record<string, any> = levelMapFile;

class MapLayer extends Layer {
    // Entities storage
    protected entities: Entity[] = [];

    // Map container
    protected mapContainer: Container;

    // Application related
    protected app: Application;
    protected res: Record<string, any>;

    // Current level's context
    private levelContext: LobbyLevelContext;

    constructor(
        ecs: ECS,
        levelContext: LobbyLevelContext,
        app: Application,
        resource: Record<string, any>
    ) {
        super("Basemap", ecs);

        this.app = app;
        this.res = resource;
        this.levelContext = levelContext;

        // Creates new pixi container
        this.mapContainer = new Container();
    }

    loadMap() {
        let rows = levelMap["height"];
        let cols = levelMap["width"];

        const step = SPRITE_SIZE / 2.0;

        let x = 0.0;
        let y = 0.0;

        for (let i = 0; i < rows; ++i) {
            y += step;
            for (let j = 0; j < cols; ++j) {
                x += step;
                const currentSheet = levelMap["data"][i][j];
                if (currentSheet !== 0) {
                    // Creates entity and add sprite to it
                    const entity = this.ecs.createEntity(x, y, false)
                    const sprite = entity.addSprite();

                    // Calculates base cuts in spritesheet
                    const pw = ((currentSheet - 1) % 10) * SPRITE_SIZE;
                    const ph = Math.floor((currentSheet - 1) / 10) * SPRITE_SIZE;

                    // Load the cuted image to sprite
                    sprite.setCutImg(
                        this.app.loader.resources["dungeon"],
                        pw, ph, SPRITE_SIZE, SPRITE_SIZE
                    );

                    this.entities.push(entity);
                    this.mapContainer.addChild(sprite.sprite);
                }
                x += step;
            }
            x = 0;
            y += step;
        }
    }

    onAttach() {
        this.loadMap();

        // Apply a ligth blur on the soil
        this.mapContainer.filters = [new filters.BlurFilter(1, 8)];

        // Add layers to render stage
        this.app.stage.addChild(this.mapContainer);
    }

    onUpdate(deltaTime: number) {
        let fixFactorX =
            (this.mapContainer.width - this.mapContainer.width * (1 - this.levelContext.zoom)) / 2.0;

        let fixFactorY =
            (this.mapContainer.height - this.mapContainer.height * (1 - this.levelContext.zoom)) / 2.0;
            
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