// Interfaces imports
import { EcsData } from "../Interfaces";

// Math imports
import { Vec2 } from "../../../Utils/Math";

// Components imports
import { Grid } from "../Components/Grid";
import { Status } from "../Components/Status";
import { Behavior } from "../Components/Behavior";
import { Rectangle } from "../Components/Rectangle";
import { Rigidbody } from "../Components/Rigidbody";
import { Transform } from "../Components/Transform";

// System index imports
import { startSystems } from "../Systems/Index";


// Systems functions types
type EcsSysEntFn = (entity: Entity, deltaTime: number) => (void);
type EcsSysContFn = (data: EcsData, deltaTime: number) => (void);
type EcsSysStratFn = (entity: Entity, grid:Grid, deltaTime: number) => (void);

// Bit masked id type
type BitMaskedId = Record<number, number>;

// Component bitmasks
const masks = {
    transform:  0b000000,
    grid:       0b000001,
    rectangle:  0b000010,
    rigidbody:  0b000100,
    status:     0b001000,
    behavior:   0b010000,
}

// Key of index in identification array
const EntityKey = 999;

// Main ECS class
class ECS {

    public gridId: number = 0;
    public statusId: number = 0;
    public behaviorId: number = 0;
    public rectangleId: number = 0;
    public rigidbodyId: number = 0;
    public transformId: number = 0;
    public entitiesId: number = 0;

    constructor() {
        startSystems(this);
    }

    // Data containers
    public grids: Record<number, Grid> = {};
    public status: Record<number, Status> = {};
    public behaviors: Record<number, Behavior> = {};
    public rectangles: Record<number, Rectangle> = {};
    public rigidbodys: Record<number, Rigidbody> = {};
    public transforms: Record<number, Transform> = {};

    // Store all entities identifications and layouts
    entities: Record<number, Entity> = {};

    // Store all systems
    containerSystems: EcsSysContFn[] = [];
    entitiesSystems: EcsSysEntFn[] = [];

    onUpdate(deltaTime: number): void {
        
        // Update all container systems
        this.containerSystems.map((fn) => {
            fn({
               grids: Object.values(this.grids),
               status: Object.values(this.status),
               behaviors: Object.values(this.behaviors),
               rectangles: Object.values(this.rectangles),
               rigidbodys: Object.values(this.rigidbodys),
               transforms: Object.values(this.transforms),
            }, deltaTime);
        });

        // Update all entities systems
        this.entitiesSystems.map((fn) => {
            Object.values(this.entities).map((entity) => {
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
        Object.values(this.entities).map((entity: Entity) => {
            entity.destroy();
        });
    }

    deleteEntity(id: BitMaskedId): void {
        const entity = this.entities[id[EntityKey]];

        // Manually remove the transform component
        delete this.transforms[id[masks.transform]];

        // Removes the rest of the components from the entity
        entity.remGrid();
        entity.remRectangle();
        entity.remStatus();
        entity.remRigidbody();
        entity.remBehavior();
        

        // Remove the entity itself from the identification array
        delete this.entities[id[EntityKey]];
    }

    createEntity(x: number = 0.0, y: number = 0.0, name: string = "", strapiId: number = 0) {
        let id: BitMaskedId = {};

        // All entities should have a transform component

        // The TransformID of entity is basically the index in the
        // array that return the component 
        id[masks.transform] = this.transformId;
        this.transformId++;

        // Create and store a new transform component in the data
        // container
        this.transforms[id[masks.transform]] = new Transform(x, y);

        // Add current location of entity in identification array
        id[EntityKey] = this.entitiesId;
        this.entitiesId++;

        // Create the effective entity representation
        const entity = new Entity(this, id, 0, name, strapiId);

        // Add it to the identification array
        this.entities[id[EntityKey]] = entity;

        return entity;
    }

};

class Entity {

    // Destroyed mark
    public destroyed: boolean = false;

    // Entity definitions
    public id: BitMaskedId;
    public layout: number;

    // By using in wrong way strapi
    public name: string;
    // Should probablly been in other component just for database
    public strapiId: number;

    // Current ecs related instance
    private ecs: ECS;

    constructor(ecs: ECS, id: BitMaskedId, layout: number, name: string, strapiId: number) {
        this.ecs = ecs;
        this.id = id;
        this.layout = layout;
        this.name = name;
        this.strapiId = strapiId;
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

    getStatus(): Status {
        if (this.layout & masks.status)
            return this.ecs.status[this.id[masks.status]];

        return this.addStatus();
    }

    getBehavior(): Behavior {
        if (this.layout & masks.behavior)
            return this.ecs.behaviors[this.id[masks.behavior]];

        return this.addBehavior();
    }

    // Adders
    addGrid(width: number = 0.0, height: number = 0.0): Grid {
        if (this.layout & masks.grid)
            return this.getGrid();

        const grid = new Grid(width, height);

        this.id[masks.grid] = this.ecs.gridId;
        this.ecs.gridId++;
        this.layout |= masks.grid;
        this.ecs.grids[this.id[masks.grid]] = grid;
        return grid;
    }

    addRectangle(width: number = 0.0, height: number = 0.0): Rectangle {
        if (this.layout & masks.rectangle)
            return this.getRectangle();

        const rectangle = new Rectangle(
            width, height,
            this.getTransform()
        );

        this.id[masks.rectangle] = this.ecs.rectangleId;
        this.ecs.rectangleId++;
        this.layout |= masks.rectangle;
        this.ecs.rectangles[this.id[masks.rectangle]] = rectangle;
        return rectangle;
    }

    addRigidbody(
        width: number = 0.0,
        height: number = 0.0,
        velocity: Vec2 = new Vec2()
    ): Rigidbody {
        if (this.layout & masks.rigidbody)
            return this.getRigidbody();

        let rigidbody;

        if (this.layout & masks.rectangle) {
            const rectangle = this.getRectangle();
            rigidbody = new Rigidbody(rectangle);
        } else {
            const rectangle = this.addRectangle(width, height);
            rigidbody = new Rigidbody(rectangle);
        }
        
        rigidbody.velocity = velocity;
        this.id[masks.rigidbody] = this.ecs.rigidbodyId;
        this.ecs.rigidbodyId++;
        this.layout |= masks.rigidbody;
        this.ecs.rigidbodys[this.id[masks.rigidbody]] = rigidbody;
        return rigidbody;
    }

    addStatus(
        attack: number = 0.0,
        speed: number = 0.0,
        health: number = 0.0,
        defense: number = 0.0,
        cooldown: number = 0.0,
        name: string = "",
        tier: string = "delta",
    ): Status {
        if (this.layout & masks.status)
            return this.getStatus();

        const status = new Status(attack, speed, health, defense, cooldown, name, tier);

        this.id[masks.status] = this.ecs.statusId;
        this.ecs.statusId++;
        this.layout |= masks.status;
        this.ecs.status[this.id[masks.status]] = status;
        return status;
    }

    addBehavior(): Behavior {
        if (this.layout & masks.behavior)
            return this.getBehavior();

        let behavior;

        if (this.layout & masks.rigidbody) {
            if (this.layout & masks.status) {
                behavior = new Behavior(
                    this.getStatus(),
                    this.getTransform(),
                    this.getRigidbody()
                );
            } else {
                const status = this.addStatus();
                behavior = new Behavior(
                    status,
                    this.getTransform(),
                    this.getRigidbody()
                );
            }
        } else {
            if (this.layout & masks.status) {
                const rigidbody = this.addRigidbody();
                behavior = new Behavior(
                    this.getStatus(),
                    this.getTransform(),
                    rigidbody
                );
            } else {
                const status = this.addStatus();
                const rigidbody = this.addRigidbody();
                behavior = new Behavior(
                    status,
                    this.getTransform(),
                    rigidbody
                );
            }
        }

        this.id[masks.behavior] = this.ecs.behaviorId;
        this.ecs.behaviorId++;
        this.layout |= masks.behavior;
        this.ecs.behaviors[this.id[masks.behavior]] = behavior;
        return behavior;
    }

    // Removers
    remGrid(): void {
        if (this.layout & masks.grid) {
            delete this.ecs.grids[this.id[masks.grid]];
            this.layout &= (~masks.grid);
        }
    }

    remRectangle() {
        if (this.layout & masks.rectangle) {
            delete this.ecs.rectangles[this.id[masks.rectangle]];
            this.layout &= (~masks.rectangle);
        }
    }

    remRigidbody() {
        if (this.layout & masks.rigidbody) {
            delete this.ecs.rigidbodys[this.id[masks.rigidbody]];
            this.layout &= (~masks.rigidbody);
        }
    }

    remStatus() {
        if (this.layout & masks.status) {
            delete this.ecs.status[this.id[masks.status]];
            this.layout &= (~masks.status);
        }
    }

    remBehavior() {
        if (this.layout & masks.behavior) {
            delete this.ecs.behaviors[this.id[masks.behavior]];
            this.layout &= (~masks.behavior);
        }
    }
    
    destroy(): void {
        this.destroyed = true;
        this.ecs.deleteEntity(this.id);
    }

};

export { ECS, Entity, EcsSysStratFn };
