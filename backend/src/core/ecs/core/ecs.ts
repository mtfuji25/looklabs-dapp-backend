
// ECS components imports
import { EcsData } from "../../interfaces";
import { GridComponent } from "../components/grid";
import { RectangleComponent } from "../components/rectangle";
import { RigidbodyComponent } from "../components/rigidbody";
import { StatusComponent } from "../components/status";
import { TransformComponent } from "../components/transform";
import { initiSystems } from "../systems";

// Types definition
type EcsFn = () => (
    TransformComponent |
    GridComponent |
    RectangleComponent |
    RigidbodyComponent |
    StatusComponent |
    null | void
);

type EcsFnPr = (width?: number, height?: number) => (
    TransformComponent |
    GridComponent |
    RectangleComponent |
    RigidbodyComponent |
    StatusComponent |
    null | void
);

type EcsSysEntFn = (entity: Entity, deltaTime: number) => (void);
type EcsSysContFn = (data: EcsData, deltaTime: number) => (void);

type BitMaskedFn = Record<number, EcsFn>;
type BitMaskedFnPr = Record<number, EcsFnPr>;

type BitMaskedId = Record<number, number>;

// Component bitmasks
const Transform = 0b000000;
const Grid = 0b000001;
const Rectangle = 0b000010;
const Rigidbody = 0b000100;
const Status = 0b001000;

// Key of index in identification array
const EntityKey = 999;

class ECS {

    constructor() {
        initiSystems(this);
    }

    // Data containers
    grids: GridComponent[] = [];
    rectangles: RectangleComponent[] = [];
    rigidbodys: RigidbodyComponent[] = [];
    transforms: TransformComponent[] = [];
    status: StatusComponent[] = [];

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
               status: this.status
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

    deleteEntity(id: BitMaskedId, layout: number): void {
        // Manually remove the transform component
        this.transforms.slice(id[Transform], 1);

        // Removes the rest of the components from the entity
        if (layout & Grid) {
            this.grids.slice(id[Grid], 1);
            layout &= (~Grid);
        }
        if (layout & Rectangle) {
            this.rectangles.slice(id[Rectangle], 1);
            layout &= (~Rectangle);
        }
        if (layout & Rigidbody) {
            this.rigidbodys.slice(id[Rigidbody], 1);
            layout &= (~Rigidbody);
        }
        // Status component
        if (layout & Status) {
            this.status.slice(id[Status], 1);
            layout &= (~Status);
        }

        // Remove the entity itself from the identification array
        this.entities.slice(id[EntityKey], 1);
    }

    createEntity(x: number = 0.0, y: number = 0.0) {
        let id: BitMaskedId = {};

        // All entities should have a transform component

        // The TransformID of entity is basically the index in the
        // array that return the component 
        id[Transform] = this.transforms.length;

        // Create and store a new transform component in the data
        // container
        this.transforms.push(new TransformComponent(x, y));

        // Add current location of entity in identification array
        id[EntityKey] = this.entities.length;

        // Create the effective entity representation
        let entity = new Entity(this, id, Transform);

        // Add it to the identification array
        this.entities.push(entity);

        return entity;
    }

};

class Entity {

    private id: BitMaskedId;
    private layout: number;

    private ecs: ECS;

    constructor(ecs: ECS, id: BitMaskedId, layout: number = Transform) {
        this.ecs = ecs;
        this.id = id;
        this.layout = layout;
    }

    getComponent: BitMaskedFn = {
        // Transform component
        0b000000: (): TransformComponent => {
            return this.ecs.transforms[this.id[Transform]];
        },

        // Grid component
        0b000001: (): GridComponent | null => {
            if (this.layout & Grid)
                return this.ecs.grids[this.id[Grid]];
            return null;
        },

        // Rectangle component
        0b000010: (): RectangleComponent | null => {
            if (this.layout & Rectangle)
                return this.ecs.rectangles[this.id[Rectangle]];
            return null;
        },

        // Rigidbody component
        0b000100: (): RigidbodyComponent | null => {
            if (this.layout & Rigidbody)
                return this.ecs.rigidbodys[this.id[Rigidbody]];
            return null;
        },

        // Status component
        0b001000: (): StatusComponent | null => {
            if (this.layout & Status)
                return this.ecs.status[this.id[Status]];
            return null;
        }
    };

    addComponent: BitMaskedFnPr = {

        // Grid component
        0b000001: (width: number = 0.0, height: number = 0.0): GridComponent => {
            if (this.layout & Grid)
                return this.ecs.grids[this.id[Grid]];

            let grid = new GridComponent(width, height);
            this.id[Grid] = this.ecs.grids.length;
            this.layout |= Grid;
            this.ecs.grids.push(grid);
            return grid;
        },

        // Rectangle component
        0b000010: (width: number = 0.0, height: number = 0.0): RectangleComponent => {
            if (this.layout & Rectangle)
                return this.ecs.rectangles[this.id[Rectangle]];

            let transform = this.ecs.transforms[this.id[Transform]];
            let rectangle = new RectangleComponent(width, height, transform);
            this.id[Rectangle] = this.ecs.rectangles.length;
            this.layout |= Rectangle;
            this.ecs.rectangles.push(rectangle);
            return rectangle;
        },

        // Rigidbody component
        0b000100: (): RigidbodyComponent | null => {
            if (this.layout & Rigidbody)
                return this.ecs.rigidbodys[this.id[Rigidbody]];

            if (this.layout & Rectangle) {
                let rectangle = this.ecs.rectangles[this.id[Rectangle]];
                let rigidbody = new RigidbodyComponent(rectangle);
                this.id[Rigidbody] = this.ecs.rigidbodys.length;
                this.layout |= Rigidbody;
                this.ecs.rigidbodys.push(rigidbody);
                return rigidbody;
            }

            return null;
        },

        // Status component
        0b001000: (health: number = 0.0, defense: number = 0.0): StatusComponent => {
            if (this.layout & Status)
                return this.ecs.status[this.id[Status]];

            const stats = new StatusComponent(health, defense);
            this.id[Status] = this.ecs.status.length;
            this.layout |= Status;
            this.ecs.status.push(stats);
            return stats;
        }
    };

    removeComponent: BitMaskedFn = {

        // Grid component
        0b000001: () => {
            if (this.layout & Grid) {
                this.ecs.grids.slice(this.id[Grid], 1);
                this.layout &= (~Grid);
            }
        },

        // Rectangle component
        0b000010: () => {
            if (this.layout & Rectangle) {
                this.ecs.rectangles.slice(this.id[Rectangle], 1);
                this.layout &= (~Rectangle);
            }
        },

        // Rigidbody component
        0b000100: () => {
            if (this.layout & Rigidbody) {
                this.ecs.rigidbodys.slice(this.id[Rigidbody], 1);
                this.layout &= (~Rigidbody);
            }
        },

        // Status component
        0b001000: () => {
            if (this.layout & Status) {
                this.ecs.status.slice(this.id[Status], 1);
                this.layout &= (~Status);
            }
        },
    };

    destroy(): void {
        this.ecs.deleteEntity(this.id, this.layout);
    }

};

export { ECS, Entity, Transform, Grid, Rectangle, Rigidbody, Status };
