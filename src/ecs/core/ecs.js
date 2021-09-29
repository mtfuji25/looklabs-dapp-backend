// Import all necessary models
import { Transform, Rectangle, RigidBody, Sprite, AnimatedSprite, TilingSprite } from "../models/models";

// It hold the data of all components
const container = {
    sprites: [],
    rectangles: [],
    transforms: [],
    rigidbodys: [],
    animatedSprites: [],
    tilingSprites: [],
    // Store all entities identification in the system
    entities: [],
    // Store all systems
    systems: [],
    globals: {},
}

const ENTITY_SYS    = 0b01;
const CONTAINER_SYS = 0b10;
const TRANSFORM     = 0b000001;
const RECTANGLE     = 0b000010;
const ANIMSPRITE    = 0b000100;
const SPRITE        = 0b001000;
const RIGIDBODY     = 0b010000;
const TILISPRITE    = 0b100000;

const ECS_CORE = {
    ENTITY_SYS: ENTITY_SYS,
    CONTAINER_SYS: CONTAINER_SYS,
    TRANSFORM      : TRANSFORM,
    RECTANGLE      : RECTANGLE,
    ANIMSPRITE     : ANIMSPRITE,
    SPRITE         : SPRITE,
    RIGIDBODY      : RIGIDBODY,
    TILISPRITE     : TILISPRITE,

    update: (deltaTime) => {
        container.sprites.forEach((comp) => {
            comp.update(deltaTime);
        });
        container.rectangles.forEach((comp) => {
            comp.update(deltaTime);
        });
        container.transforms.forEach((comp) => {
            comp.update(deltaTime);
        });
        container.rigidbodys.forEach((comp) => {
            comp.update(deltaTime);
        });
        container.animatedSprites.forEach((comp) => {
            comp.update(deltaTime);
        });

        let data = {};
        data[TRANSFORM] = container.transforms;
        data[RECTANGLE] = container.rectangles;
        data[ANIMSPRITE] = container.animatedSprites;
        data[SPRITE] = container.sprites;
        data[RIGIDBODY] = container.rigidbodys;
        data[TILISPRITE] = container.tilingSprites;

        container.systems.forEach((system) => {
            if (system.type & ENTITY_SYS) {
                container.entities.forEach((entity) => {
                    system.fn(entity, deltaTime);
                });
            } else if (system.type & CONTAINER_SYS) {
                system.fn(data, deltaTime);
            }
        });
    },

    registerSystem: (system, sysType) => {
        container.systems.push({
            fn: system,
            type: sysType
        });
    },

    setGlobal: (key, value) => {
        container.globals[key] = { value };
    },

    getGlobal: (key) => {
        return container.globals[key].value;
    }
}

const ECS = {
    // Components masks
    TRANSFORM      : TRANSFORM,
    RECTANGLE      : RECTANGLE,
    ANIMSPRITE     : ANIMSPRITE,
    SPRITE         : SPRITE,
    RIGIDBODY      : RIGIDBODY,
    TILISPRITE     : TILISPRITE,

    getComponent: (entity, layout) => {
        let components = {};
    
        if (entity.layout & TRANSFORM) {
            components[TRANSFORM] = container.transforms[entity.ids[TRANSFORM]];
        }
        if (entity.layout & RECTANGLE) {
            components[RECTANGLE] = container.rectangles[entity.ids[RECTANGLE]];
        }
        if (entity.layout & RIGIDBODY) {
            components[RIGIDBODY] = container.rigidbodys[entity.ids[RIGIDBODY]];
        }
        if (entity.layout & SPRITE) {
            components[SPRITE] = container.sprites[entity.ids[SPRITE]];
        }
        if (entity.layout & ANIMSPRITE) {
            components[ANIMSPRITE] = container.animatedSprites[entity.ids[ANIMSPRITE]];
        }
        if (entity.layout & TILISPRITE) {
            components[TILISPRITE] = container.tilingSprites[entity.ids[TILISPRITE]];
        }
    
        if ([TRANSFORM, SPRITE, ANIMSPRITE, RIGIDBODY, RECTANGLE, TILISPRITE].some((i) => (i == layout))) {
            return components[layout];
        } else {
            return components;
        }
    },
    
    removeComponent: (entity, layout) => {
        // User cannot remove this component
        if (layout & TRANSFORM)
            return -1;
    
        if (layout & RECTANGLE) {
            container.RECTANGLE.slice(entity.ids[RECTANGLE], 1);
            entity.layout &= (~RECTANGLE);
        }
        if (layout & RIGIDBODY) {
            container.rigidbodys.slice(entity.ids[RIGIDBODY], 1);
            entity.layout &= (~RIGIDBODY);
        }
        if (layout & SPRITE) {
            container.sprites.slice(entity.ids[SPRITE], 1);
            entity.layout &= (~SPRITE);
        }
        if (layout & ANIMSPRITE) {
            container.animatedSprites.slice(entity.ids[ANIMSPRITE], 1);
            entity.layout &= (~ANIMSPRITE);
        }
        if (layout & TILISPRITE) {
            container.tilingSprites.slice(entity.ids[TILISPRITE], 1);
            entity.layout &= (~TILISPRITE);
        }
    },
    
    addComponent: (entity, layout) => {
        let transform = ECS.getComponent(entity, TRANSFORM);

        let components = {};

        if (entity.layout & layout)
            return -1;
    
        if (layout & RECTANGLE) {
            // Creates the nem component
            let rectangle = new Rectangle(transform);
    
            // Store it in the container
            container.rectangles.push(rectangle);
    
            // Get the current index of the component and make it as the id
            entity.ids[RECTANGLE] = (container.rectangles.length - 1);
    
            // Add the component kind to the mask
            entity.layout |= RECTANGLE;
    
            // Add the current component to the dictionary
            components[RECTANGLE] = rectangle;
        }
    
        // All other components follow the same logic as the shown above
        if (layout & RIGIDBODY) {
            let rigidbody = new RigidBody(transform);
            container.rigidbodys.push(rigidbody);
            entity.ids[RIGIDBODY] = (container.rigidbodys.length - 1);
            entity.layout |= RIGIDBODY;
            components[RIGIDBODY] = rigidbody;
        }
        if (layout & SPRITE) {
            let sprite = new Sprite(transform);
            container.sprites.push(sprite);
            entity.ids[SPRITE] = (container.sprites.length - 1);
            entity.layout |= SPRITE;
            components[SPRITE] = sprite;
        }
        if (layout & ANIMSPRITE) {
            let animatedSprite = new AnimatedSprite(transform);
            container.animatedSprites.push(animatedSprite);
            entity.ids[ANIMSPRITE] = (container.animatedSprites.length - 1);
            entity.layout |= ANIMSPRITE;
            components[ANIMSPRITE] = animatedSprite;
        }
        if (layout & TILISPRITE) {
            let tilingSprite = new TilingSprite(transform);
            container.tilingSprites.push(tilingSprite);
            entity.ids[TILISPRITE] = (container.tilingSprites.length - 1);
            entity.layout |= TILISPRITE;
            components[TILISPRITE] = tilingSprite;
        }
    
        if ([TRANSFORM, SPRITE, ANIMSPRITE, RIGIDBODY, RECTANGLE, TILISPRITE].some((i) => (i == layout))) {
            return components[layout];
        } else {
            return components;
        }
    },
    
    // Delete an entity from the system and removes it components
    deleteEntity: (entity) => {
        // It check if the entity has the component, case true
        // removes it from the container
        if (entity.layout & TRANSFORM) {
            container.transforms.slice(entity.ids[TRANSFORM], 1);
        }
        ECS.removeComponent(entity, RECTANGLE | ANIMSPRITE | SPRITE | RIGIDBODY | TILISPRITE);
    
        // Remove the entity itself from the array
        container.entities.slice(entity.ids["entity"], 1);
    },
    
    // Create an entity in the system and add required components
    createEntity: (x = 0.0, y = 0.0, layout = 0b00000) => {
    
        let entity = {
            ids: {},
            layout: 0b00000,
        };
    
        // All entities should have a transform component
    
        // Create and store a new transform component in the data
        // container
        let transform = new Transform(x, y);
        container.transforms.push(transform);
    
        // The TransformID of entity is basically the index in the
        // array that return the component 
        entity.ids[TRANSFORM] = (container.transforms.length - 1);
    
        entity.layout |= TRANSFORM;

        // The same process for transform is valid for other components
        // so the rest of the code just repeat this process
        if (!(layout & TRANSFORM))
            ECS.addComponent(entity, layout);
    
        // Store the current entity in the entities arrya, so now
        // it will start to be updated by the systems
        container.entities.push(entity);
        entity.ids["entity"] = (container.entities.length - 1)
    
        return entity;
    },

    setGlobal: (key, value) => {
        container.globals[key] = { value };
    },

    getGlobal: (key) => {
        return container.globals[key].value;
    }
};

export { ECS, ECS_CORE };