// Layer import
import { Layer } from "../../Core/Layer";

// Constants
import { SPRITE_SIZE } from "../../Constants/Constants";

// Ecs imports
import { ECS, Entity } from "../../Core/Ecs/Core/Ecs";

// Pixi imports
import { Application, Container} from "pixi.js";


// Files import
import { Vec2 } from "../../Utils/Math";

class MapLayer extends Layer {
    // Entities storage
    protected entities: Entity[] = [];

    // Map container
    protected mapContainer: Container;

    // Application related
    protected app: Application;
    protected res: Record<string, any>;
    private levelMap: Record<string, any>;
    private screenX: number;
    private screenY: number;
    
    // Dimension
    private dim: Vec2 = new Vec2();

    constructor(
        ecs: ECS,
        app: Application,
        resource: Record<string, any>,
        levelMap: Record<string, any>
    ) {
        super("Basemap", ecs);

        this.app = app;
        this.res = resource;
        this.screenX = this.app.view.clientWidth;
        this.screenY = this.app.view.clientHeight;

        this.levelMap = levelMap;

        // Creates new pixi container
        this.mapContainer = new Container();
    }

    loadMap() {
        let rows = this.levelMap["height"];
        let cols = this.levelMap["width"];

        const step = SPRITE_SIZE / 2.0;

        let x = 0.0;
        let y = 0.0;

        for (let i = 0; i < rows; ++i) {
            y += step;
            for (let j = 0; j < cols; ++j) {
                x += step;

                // Creates entity and add sprite to it
                const entity = this.ecs.createEntity(x, y, false)
                const sprite = entity.addSprite();

                // Calculates base cuts in spritesheet
                const pw = j * SPRITE_SIZE;
                const ph = i * SPRITE_SIZE;

                // Load the cuted image to sprite
                sprite.setCutImg(
                    this.app.loader.resources["basemap"],
                    pw, ph, SPRITE_SIZE, SPRITE_SIZE
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
