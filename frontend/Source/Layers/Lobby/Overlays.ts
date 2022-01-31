// Layer import
import { Layer } from "../../Core/Layer";

// Constants
import { SPRITE_SIZE } from "../../Constants/Constants";

// Ecs imports
import { ECS, Entity } from "../../Core/Ecs/Core/Ecs";

// Pixi imports
import { Application, Container } from "pixi.js";

// Lobby level context
import { LobbyLevelContext } from "../../Levels/Lobby";

// Files import
import levelMapFile from "../../Assets/level_overlays.json"
import { Vec2 } from "../../Utils/Math";

const levelMap: Record<string, any> = levelMapFile;

class OverlayMap extends Layer {
    // Entities storage
    protected entities: Entity[] = [];

    // Map container
    protected mapContainer: Container;

    // Application related
    protected app: Application;
    protected res: Record<string, any>;

    // Current level's context
    private levelContext: LobbyLevelContext;

    private overlayFixtures:Entity[] = [];

    // these are the texture cells used in the creation of map's tall obstacles (lockers, and clone tubes)
    private fixtureIndexes:Set<number> = new Set([95, 96, 97, 98, 99, 100,101, 102,  103, 104, 105, 106, 107, 108, 109, 110, 111, 112,113, 114,115, 116,117, 118,166, 167,168, 169,187, 188,189, 190,207, 208,209, 210,226, 227,228, 229]);
    // Dimension
    private dim: Vec2 = new Vec2();

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
    
    //asset created with http://cache.andre-michelle.com/tools/html/tileset-extractor.html
    loadMap() {
        let rows = levelMap["height"];
        let cols = levelMap["width"];

        const step = SPRITE_SIZE / 2.0;

   

        for (let i = 0; i < rows; ++i) {
            
            for (let j = 0; j < cols; ++j) {
                const currentCell = levelMap["data"][i][j];
                const entity = this.ecs.createEntity(j * SPRITE_SIZE, i * SPRITE_SIZE, false);
                const sprite = entity.addSprite();
                sprite.setCutImg(
                    this.app.loader.resources["map-overlay"],
                    // 26 is the number of columns in the sprite sheet
                    Math.floor(((currentCell) % 26)) * SPRITE_SIZE,
                    Math.floor((currentCell) / 26) * SPRITE_SIZE,
                    SPRITE_SIZE,
                    SPRITE_SIZE
                );
                this.entities.push(entity);
                if (this.fixtureIndexes.has(currentCell)) {
                    this.overlayFixtures.push(entity);
                }
                if (currentCell == 0) entity.getSprite().sprite.alpha = 0.0;
                this.mapContainer.addChild(sprite.sprite);  
            }
        }
    }
    

    onAttach() {
        this.loadMap();

        this.dim.x = this.mapContainer.width;
        this.dim.y = this.mapContainer.height;

        // Add layers to render stage
        this.app.stage.addChild(this.mapContainer);
        this.onUpdate(0);
    }

    onUpdate(deltaTime: number) {
        let fixFactorX =
            (this.dim.x - this.dim.x * (1 - this.levelContext.zoom)) / 2.0;

        let fixFactorY =
            (this.dim.y - this.dim.y * (1 - this.levelContext.zoom)) / 2.0;
            
        // Translate and scale soil
        this.mapContainer.x = this.levelContext.offsetX + fixFactorX + SPRITE_SIZE * 0.5;
        this.mapContainer.y = this.levelContext.offsetY + fixFactorY + SPRITE_SIZE * 0.5;
        this.mapContainer.scale.x = 1 - this.levelContext.zoom;
        this.mapContainer.scale.y = 1 - this.levelContext.zoom;
    }

    onDetach() {
        this.app.stage.removeChild(this.mapContainer);
    }

    getContainer ():Container {
        return this.mapContainer;
    }

    //we hide the textures for lockers and test tubes so these can be added inside PlayerLayer and y-sorted
    hideFixtures () {
        this.overlayFixtures.forEach( o => {
            o.getSprite().sprite.visible = false;
        });
    }


}

export { OverlayMap };