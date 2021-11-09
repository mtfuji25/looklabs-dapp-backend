
// ECS components imports
import { EcsData, EngineContext } from "../../interfaces";
import { SpriteComponent } from "../components/sprite";
import { AnimSpriteComponent } from "../components/animsprite";
import { TransformComponent } from "../components/transform";
import { initiSystems } from "../systems";

// Types definition
type EcsFn = () => (
    TransformComponent |
    SpriteComponent |
    AnimSpriteComponent |
    null | void
);

type EcsFnPr = (width?: number, height?: number) => (
    TransformComponent |
    SpriteComponent |
    AnimSpriteComponent |
    null | void
);

type EcsSysEntFn = (entity: Entity, context: EngineContext, deltaTime: number) => (void);
type EcsSysContFn = (data: EcsData, context: EngineContext, deltaTime: number) => (void);

type BitMaskedFn = Record<number, EcsFn>;
type BitMaskedFnPr = Record<number, EcsFnPr>;

type BitMaskedId = Record<number, number>;

// Component bitmasks
const Transform = 0b000000;
const Sprite = 0b000001;
const AnimSprite = 0b000010;

// Key of index in identification array
const EntityKey = 999;

class ECS {

    public context: EngineContext;

    constructor(context: EngineContext) {
        this.context = context;
        initiSystems(this);
    }

    // Data containers
    sprites: SpriteComponent[] = [];
    animsprites: AnimSpriteComponent[] = [];
    transforms: TransformComponent[] = [];

    // Store all entities identifications and layouts
    entities: Entity[] = [];

    // Store all systems
    containerSystems: EcsSysContFn[] = [];
    entitiesSystems: EcsSysEntFn[] = [];

    onUpdate(deltaTime: number): void {
        
        // Update all container systems
        this.containerSystems.map((fn) => {
            fn({
               sprites: this.sprites,
               animsprites: this.animsprites,
               transforms: this.transforms,
            }, this.context, deltaTime);
        });

        // Update all entities systems
        this.entitiesSystems.map((fn) => {
            this.entities.map((entity) => {
               fn(entity, this.context, deltaTime);
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
        if (layout & Sprite) {
            this.sprites.slice(id[Sprite], 1);
            layout &= (~Sprite);
        }
        if (layout & AnimSprite) {
            this.animsprites.slice(id[AnimSprite], 1);
            layout &= (~AnimSprite);
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

        // Sprite component
        0b000001: (): SpriteComponent | null => {
            if (this.layout & Sprite)
                return this.ecs.sprites[this.id[Sprite]];
            return null;
        },

        // Animsprite component
        0b000010: (): AnimSpriteComponent | null => {
            if (this.layout & AnimSprite)
                return this.ecs.animsprites[this.id[AnimSprite]];
            return null;
        }
    };

    addComponent: BitMaskedFnPr = {
        // Sprite component
        0b000001: (): SpriteComponent => {
            if (this.layout & Sprite)
                return this.ecs.sprites[this.id[Sprite]];

            const transform = this.ecs.transforms[this.id[Transform]];
            const sprite = new SpriteComponent(transform);
            this.id[Sprite] = this.ecs.sprites.length;
            this.layout |= Sprite;
            this.ecs.sprites.push(sprite);
            return sprite;
        },

        // Animsprite component
        0b000010: (): AnimSpriteComponent => {
            if (this.layout & AnimSprite)
                return this.ecs.animsprites[this.id[AnimSprite]];

            const transform = this.ecs.transforms[this.id[Transform]];
            const animsprite = new AnimSpriteComponent(transform);
            this.id[AnimSprite] = this.ecs.animsprites.length;
            this.layout |= AnimSprite;
            this.ecs.animsprites.push(animsprite);
            return animsprite;
        },
    };

    removeComponent: BitMaskedFn = {

        // Sprite component
        0b000001: () => {
            if (this.layout & Sprite) {
                this.ecs.sprites.slice(this.id[Sprite], 1);
                this.layout &= (~Sprite);
            }
        },

        // Animsprite component
        0b000010: () => {
            if (this.layout & AnimSprite) {
                this.ecs.animsprites.slice(this.id[AnimSprite], 1);
                this.layout &= (~AnimSprite);
            }
        }
    };

    destroy(): void {
        this.ecs.deleteEntity(this.id, this.layout);
    }

};

export { ECS, Entity, Transform, Sprite, AnimSprite };
