// Math imports
import { Vec2 } from "../../../Utils/Math";

// ECS imports
import { Entity } from "../Core/Ecs";

// Components imports
import { Rectangle } from "./Rectangle";
import { Transform } from "./Transform";

interface DynamicEntity {
    entity: Entity;
    index: Vec2;
    ocupations: Vec2[];
}

class Grid {

    // Size properties
    width: number;
    height: number;

    // Intervals of each cell
    intervalX: number;
    intervalY: number;

    // Stores all statics entities
    statics: Array<Rectangle | null> = [];

    // Stores all dynamic entities
    dynamics: Array<DynamicEntity> = [];

    constructor(width: number = 0, height: number = 0) {
        this.width = width;
        this.height = height;

        // Get current single cell size
        this.intervalX = 2.0 / this.width;
        this.intervalY = 2.0 / this.height;

        // First initialize all static cells as false
        this.statics = new Array<null>(this.width * this.height);

    }

    addDynamic(entity: Entity) {
        const transform = entity.getTransform();
        const rectangle = entity.getRectangle();

        // Changes coordinate sistem from ndc to normalized left-upper origin
        const position = transform.pos.adds(1.0).divs(2.0);
        position.y = 1 - position.y;

        // Find the correct index of entity in grid
        const index = new Vec2(
            Math.floor(position.x / (this.intervalX / 2.0)),
            Math.floor(position.y / (this.intervalY / 2.0)),
        );

        const index1 = new Vec2(
            Math.floor((position.x - (rectangle.width / 2.0)) / (this.intervalX / 2.0)),
            Math.floor((position.y - (rectangle.height / 2.0)) / (this.intervalY / 2.0)),
        );

        const index2 = new Vec2(
            Math.floor((position.x + (rectangle.width / 2.0)) / (this.intervalX / 2.0)),
            Math.floor((position.y + (rectangle.height / 2.0)) / (this.intervalY / 2.0)),
        );

        // If index gets out of bounds return
        if (index.x >= this.width || index.y >= this.height)
            return;

        this.dynamics.push({ 
            entity: entity, 
            index: index, 
            ocupations: [
                index1,
                new Vec2(index2.x, index1.y),
                new Vec2(index1.x, index2.y),
                index2
            ]
        });
    }

    removeDynamic(entity: Entity) {
        this.dynamics = this.dynamics.filter(dynamic => dynamic.entity !== entity);
    }

    getDynamic(entity: Entity) {
        return this.dynamics.find((dynamic) => dynamic.entity === entity);
    }

    addStatic(x: number, y: number) {
        if (x < 0 || x >= this.width || y < 0 || y >= this.height)
            return;

        this.statics[y * this.width + x] = new Rectangle(
            this.intervalX, this.intervalY,
            new Transform(
                ((x * this.intervalX + this.intervalX / 2.0)) - 1.0,
                1.0 - ((y * this.intervalY + this.intervalY / 2.0))
            )
        );
    }

    removeStatic(x: number, y: number) {
        this.statics[y * this.width + x] = null;
    }
};

export { Grid };
