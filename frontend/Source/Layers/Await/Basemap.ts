// Layer import
import { Layer } from "../../Core/Layer";

// Constants
import { SPRITE_SIZE } from "../../Constants/Constants";

// Ecs imports
import { ECS, Entity } from "../../Core/Ecs/Core/Ecs";

// Pixi imports
import { Application, Container, filters } from "pixi.js";


// Files import
import levelMapFile from "../../Assets/level_map.json"
import { Vec2 } from "../../Utils/Math";

const levelMap: Record<string, any> = levelMapFile;

class MapLayer extends Layer {
    // Entities storage
    protected entities: Entity[] = [];

    // Map container
    protected mapContainer: Container;

    // Application related
    protected app: Application;
    protected res: Record<string, any>;
    private screenX: number;
    private screenY: number;
    
    // Dimension
    private dim: Vec2 = new Vec2();

    constructor(
        ecs: ECS,
        app: Application,
        resource: Record<string, any>
    ) {
        super("Basemap", ecs);

        this.app = app;
        this.res = resource;
        this.screenX = this.app.view.clientWidth;
        this.screenY = this.app.view.clientHeight;
        // Creates new pixi container
        this.mapContainer = new Container();
    }

    //asset created with http://cache.andre-michelle.com/tools/html/tileset-extractor.html
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
                const currentCell = levelMap["data"][i][j];
                const entity = this.ecs.createEntity(x, y, false);
                const sprite = entity.addSprite();
                sprite.setCutImg(
                    this.app.loader.resources["map"],
                    Math.floor(((currentCell - 1) % 19)) * 16,
                    Math.floor((currentCell - 1) / 19) * 16,
                    16,
                    16
                );
                this.entities.push(entity);
                this.mapContainer.addChild(sprite.sprite);
              
                
            
                x += step;
            }
            x = 0;
            y += step;
        }
    }

    onAttach() {
        this.loadMap();

        this.dim.x = this.mapContainer.width;
        this.dim.y = this.mapContainer.height;

        this.mapContainer.x = (this.screenX - this.dim.x) * 0.5;
        this.mapContainer.y = (this.screenY - this.dim.y) * 0.5;
        
        this.app.stage.addChild(this.mapContainer);
        
        this.onUpdate(0);
    }

    onUpdate(deltaTime: number) {
        if(this.app.view.clientWidth !== this.screenX || this.app.view.clientHeight !== this.screenY) {
            this.screenX = this.app.view.clientWidth;
            this.screenY = this.app.view.clientHeight;
            
            this.mapContainer.x = (this.screenX - this.dim.x) * 0.5;
            this.mapContainer.y = (this.screenY - this.dim.y) * 0.5;

        }

    }
  

    onDetach() {
        this.app.stage.removeChild(this.mapContainer);
    }
}

export { MapLayer };
