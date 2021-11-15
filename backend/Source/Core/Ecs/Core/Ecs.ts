// Interfaces imports
import { EcsData } from "../Interfaces";

// Math imports
import { Vec2 } from "../../../Utils/Math";

// Components imports
import { Grid } from "../Components/Grid";
import { Rectangle } from "../Components/Rectangle";
import { Rigidbody } from "../Components/Rigidbody";
import { Transform } from "../Components/Transform";

// System index imports
import { startSystems } from "../Systems/Index";

// Systems functions types
type EcsSysEntFn = (entity: Entity, deltaTime: number) => (void);
type EcsSysContFn = (data: EcsData, deltaTime: number) => (void);

// Bit masked id type
type BitMaskedId = Record<number, number>;

// Component bitmasks
const masks = {
    transform:  0b000000,
    grid:       0b000001,
    rectangle:  0b000010,
    rigidbody:  0b000100,
}

// Key of index in identification array
const EntityKey = 999;

// Main ECS class
class ECS {

    constructor() {
        startSystems(this);
    }

    // Data containers
    public grids: Grid[] = [];
    public rectangles: Rectangle[] = [];
    public rigidbodys: Rigidbody[] = [];
    public transforms: Transform[] = [];

    // Store all entities identifications and layouts
    entities: Entity[] = [];

    // Store all systems
    containerSystems: EcsSysContFn[] = [];
    entitiesSystems: EcsSysEntFn[] = [];

    onUpdate(deltaTime: number): void {
        
        // Update all container systems
        this.containerSystems.map((fn) => {
            fn({
               grids: this.grids,
               rectangles: this.rectangles,
               rigidbodys: this.rigidbodys,
               transforms: this.transforms,
            }, deltaTime);
        });

        // Update all entities systems
        this.entitiesSystems.map((fn) => {
            this.entities.map((entity) => {
               fn(entity, deltaTime);
            });
        });
    }

    pushContainerSystem(fn: EcsSysContFn): void {
        this.containerSystems.push(fn);
    }

    pushEntitySystem(fn: EcsSysEntFn): void {
        this.entitiesSystems.push(fn);
    }

    destroy() {
        this.entities.map((entity: Entity) => {
            entity.destroy();
        });
    }

    deleteEntity(entity: Entity): void {
        // Manually remove the transform component
        this.transforms.slice(entity.id[masks.transform], 1);

        // Removes the rest of the components from the entity
        entity.remGrid();

        entity.remRectangle();
        
        entity.remRigidbody();

        // Remove the entity itself from the identification array
        this.entities.slice(entity.id[EntityKey], 1);
    }

    createEntity(x: number = 0.0, y: number = 0.0) {
        let id: BitMaskedId = {};

        // All entities should have a transform component

        // The TransformID of entity is basically the index in the
        // array that return the component 
        id[masks.transform] = this.transforms.length;

        // Create and store a new transform component in the data
        // container
        this.transforms.push(new Transform(x, y));

        // Add current location of entity in identification array
        id[EntityKey] = this.entities.length;

        // Create the effective entity representation
        const entity = new Entity(this, id, masks.transform);

        // Add it to the identification array
        this.entities.push(entity);

        return entity;
    }

};

class Entity {

    // Entity definitions
    public id: BitMaskedId;
    public layout: number;

    // Current ecs related instance
    private ecs: ECS;

    constructor(ecs: ECS, id: BitMaskedId, layout: number) {
        this.ecs = ecs;
        this.id = id;
        this.layout = layout;
    }

    // Getters
    getTransform(): Transform {
        return this.ecs.transforms[this.id[masks.transform]];
    }

    getGrid(): Grid {
        if (this.layout & masks.grid)
            return this.ecs.grids[this.id[masks.grid]];
        
        return this.addGrid();
    }

    getRectangle(): Rectangle {
        if (this.layout & masks.rectangle)
            return this.ecs.rectangles[this.id[masks.rectangle]];

        return this.addRectangle();
    }

    getRigidbody(): Rigidbody {
        if (this.layout & masks.rigidbody)
            return this.ecs.rigidbodys[this.id[masks.rigidbody]];

        return this.addRigidbody();
    }

    // Adders
    addGrid(width: number = 0.0, height: number = 0.0): Grid {
        if (this.layout & masks.grid)
            return this.getGrid();

        const grid = new Grid(width, height);

        this.id[masks.grid] = this.ecs.grids.length;
        this.layout |= masks.grid;
        this.ecs.grids.push(grid);
        return grid;
    }

    addRectangle(width: number = 0.0, height: number = 0.0): Rectangle {
        if (this.layout & masks.rectangle)
            return this.getRectangle();

        const rectangle = new Rectangle(
            width, height,
            this.getTransform()
        );

        this.id[masks.rectangle] = this.ecs.rectangles.length;
        this.layout |= masks.rectangle;
        this.ecs.rectangles.push(rectangle);
        return rectangle;
    }

    addRigidbody(
        width: number = 0.0,
        height: number = 0.0,
        velocity: Vec2 = new Vec2()
    ): Rigidbody {
        if (this.layout & masks.rigidbody)
            return this.getRigidbody()

        let rigidbody;

        if (this.layout & masks.rectangle) {
            const rectangle = this.getRectangle();
            rigidbody = new Rigidbody(rectangle);
        } else {
            const rectangle = this.addRectangle(width, height);
            rigidbody = new Rigidbody(rectangle);
        }

        this.id[masks.rigidbody] = this.ecs.rigidbodys.length;
        this.layout |= masks.rigidbody;
        this.ecs.rigidbodys.push(rigidbody);
        return rigidbody;
    }

    // Removers
    remGrid(): void {
        if (this.layout & masks.grid) {
            this.ecs.grids.slice(this.id[masks.grid], 1);
            this.layout &= (~masks.grid);
        }
    }

    remRectangle() {
        if (this.layout & masks.rectangle) {
            this.ecs.rectangles.slice(this.id[masks.rectangle], 1);
            this.layout &= (~masks.rectangle);
        }
    }

    remRigidbody() {
        if (this.layout & masks.rigidbody) {
            this.ecs.rigidbodys.slice(this.id[masks.rigidbody], 1);
            this.layout &= (~masks.rigidbody);
        }
    }

    destroy(): void {
        this.ecs.deleteEntity(this);
    }

};

export { ECS, Entity };
