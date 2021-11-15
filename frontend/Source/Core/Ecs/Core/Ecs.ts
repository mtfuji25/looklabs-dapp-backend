// Interfaces imports
import { EcsData } from "../Interfaces";

// Math imports
import { Vec2 } from "../../../Utils/Math";

// Components imports
import { Text } from "../Components/Text";
import { Sprite } from "../Components/Sprite";
import { Transform } from "../Components/Transform";
import { AnimSprite } from "../Components/AnimSprite";

// System index imports
import { startSystems } from "../Systems/Index";

// Pixi imports
import { LoaderResource } from "pixi.js";
import { ITextStyle } from "@pixi/text";

// Systems functions types
type EcsSysEntFn = (entity: Entity, deltaTime: number) => (void);
type EcsSysContFn = (data: EcsData, deltaTime: number) => (void);

// Bit masked id type
type BitMaskedId = Record<number, number>;

// Component bitmasks
const masks = {
    transform:      0b000000,
    text:           0b000001,
    sprite:         0b000010,
    animsprite:     0b000100,
}

// Key of index in identification array
const EntityKey = 999;

// Main ECS class
class ECS {

    constructor() {
        startSystems(this);
    }

    // Data containers
    public texts: Text[] = [];
    public sprites: Sprite[] = [];
    public transforms: Transform[] = [];
    public animsprites: AnimSprite[] = [];

    // Store all entities identifications and layouts
    entities: Entity[] = [];

    // Store all systems
    containerSystems: EcsSysContFn[] = [];
    entitiesSystems: EcsSysEntFn[] = [];

    onUpdate(deltaTime: number): void {
        
        // Update all container systems
        this.containerSystems.map((fn) => {
            fn({
               texts: this.texts,
               sprites: this.sprites,
               transforms: this.transforms,
               animsprites: this.animsprites
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
        entity.remText();

        entity.remSprite();
        
        entity.remAnimSprite();

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

    getText(): Text {
        if (this.layout & masks.text)
            return this.ecs.texts[this.id[masks.text]];
        
        return this.addText();
    }

    getSprite(): Sprite {
        if (this.layout & masks.sprite)
            return this.ecs.sprites[this.id[masks.sprite]];

        return this.addSprite();
    }

    getAnimSprite(): AnimSprite {
        if (this.layout & masks.animsprite)
            return this.ecs.animsprites[this.id[masks.animsprite]];

        return this.addAnimSprite();
    }

    // Adders
    addText(
        content: string = "",
        styles: Partial<ITextStyle> = {
            fontFamily: "monospace",
            fontSize: 16,
            fill: 0xffffff,
            align: "center",
            fontWeight: "400",
            lineHeight: 22.4,  
        }
    ): Text {
        if (this.layout & masks.text)
            return this.getText();

        const text = new Text(
            this.getTransform(),
            content, styles
        );

        this.id[masks.text] = this.ecs.texts.length;
        this.layout |= masks.text;
        this.ecs.texts.push(text);
        return text;
    }

    addSprite(img: LoaderResource | null = null): Sprite {
        if (this.layout & masks.sprite)
            return this.getSprite();

        const sprite = new Sprite(this.getTransform(), img);

        this.id[masks.sprite] = this.ecs.sprites.length;
        this.layout |= masks.sprite;
        this.ecs.sprites.push(sprite);
        return sprite;
    }

    addAnimSprite(): AnimSprite {
        if (this.layout & masks.animsprite)
            return this.getAnimSprite()

        const animsprite = new AnimSprite(this.getTransform());

        this.id[masks.animsprite] = this.ecs.animsprites.length;
        this.layout |= masks.animsprite;
        this.ecs.animsprites.push(animsprite);
        return animsprite;
    }

    // Removers
    remText(): void {
        if (this.layout & masks.text) {
            this.ecs.texts[this.id[masks.text]].remStage();
            this.ecs.texts.slice(this.id[masks.text], 1);
            this.layout &= (~masks.text);
        }
    }

    remSprite(): void {
        if (this.layout & masks.sprite) {
            this.ecs.sprites[this.id[masks.sprite]].remStage();
            this.ecs.sprites.slice(this.id[masks.sprite], 1);
            this.layout &= (~masks.sprite);
        }
    }

    remAnimSprite(): void {
        if (this.layout & masks.animsprite) {
            this.ecs.animsprites[this.id[masks.animsprite]].remStage();
            this.ecs.animsprites.slice(this.id[masks.animsprite], 1);
            this.layout &= (~masks.animsprite);
        }
    }

    destroy(): void {
        this.ecs.deleteEntity(this);
    }

};

export { ECS, Entity };
