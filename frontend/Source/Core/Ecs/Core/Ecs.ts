// Interfaces imports
import { EcsData } from "../Interfaces";

// Math imports
import { Vec2 } from "../../../Utils/Math";

// Components imports
import { Text } from "../Components/Text";
import { Sprite } from "../Components/Sprite";
import { Transform } from "../Components/Transform";
import { AnimSprite } from "../Components/AnimSprite";
import { ColoredRectangle } from "../Components/ColoredRectangle";
import { Panel } from "../Components/Panel";

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
    coloredRec:     0b001000,
    panel:          0b010000,
}

// Key of index in identification array
const EntityKey = 999;

// Main ECS class
class ECS {

    constructor() {
        startSystems(this);
    }

    public id = {
        text: 0,
        sprite: 0,
        transform: 0,
        animSprite: 0,
        coloredRec: 0,
        panel: 0,
        entity: 0
    }

    // Data containers
    public texts: Record<number, Text> = {};
    public sprites: Record<number, Sprite> = {};
    public transforms: Record<number, Transform> = {};
    public animsprites: Record<number, AnimSprite> = {};
    public coloredRecs: Record<number, ColoredRectangle> = {};
    public panels: Record<number, Panel> = {};

    // Store all entities identifications and layouts
    entities: Record<number, Entity> = {};

    // Store all systems
    containerSystems: EcsSysContFn[] = [];
    entitiesSystems: EcsSysEntFn[] = [];

    onUpdate(deltaTime: number): void {
        
        // Update all container systems
        this.containerSystems.map((fn) => {
            fn({
               texts: Object.values(this.texts),
               sprites: Object.values(this.sprites),
               transforms: Object.values(this.transforms),
               animsprites: Object.values(this.animsprites),
               coloredRecs: Object.values(this.coloredRecs),
               panels: Object.values(this.panels),
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
        // Get current entity
        const entity = this.entities[id[EntityKey]];

        // Manually remove the transform component
        delete this.transforms[id[masks.transform]];

        // Removes the rest of the components from the entity
        entity.remText();

        entity.remSprite();
        
        entity.remAnimSprite();

        entity.remColoredRectangle();

        // Remove the entity itself from the identification array
        delete this.entities[id[EntityKey]];
    }

    createEntity(x: number = 0.0, y: number = 0.0, refresh: boolean = true) {
        let id: BitMaskedId = {};

        // All entities should have a transform component

        // The TransformID of entity is basically the index in the
        // array that return the component 
        id[masks.transform] = this.id.transform;
        this.id.transform++;

        // Create and store a new transform component in the data
        // container
        this.transforms[id[masks.transform]] = new Transform(x, y);

        // Add current location of entity in identification array
        id[EntityKey] = this.id.entity;
        this.id.entity++;

        // Create the effective entity representation
        const entity = new Entity(this, id, masks.transform);
        entity.refresh = refresh;
        // Add it to the identification array
        this.entities[id[EntityKey]] = entity;

        return entity;
    }

};

class Entity {

    // Entity definitions
    public id: BitMaskedId;
    public layout: number;
    public refresh: boolean;

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

    getColoredRectangle(): ColoredRectangle {
        if (this.layout & masks.coloredRec)
            return this.ecs.coloredRecs[this.id[masks.coloredRec]];

        return this.addColoredRectangle();
    }

    getPanel(img: LoaderResource): Panel {
        if (this.layout & masks.panel)
            return this.ecs.panels[this.id[masks.panel]];

        return this.addPanel(img);
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
        text.refresh = this.refresh;

        this.id[masks.text] = this.ecs.id.text;
        this.ecs.id.text++;

        this.layout |= masks.text;
        this.ecs.texts[this.id[masks.text]] = text;
        return text;
    }

    addSprite(img: LoaderResource | null = null): Sprite {
        if (this.layout & masks.sprite)
            return this.getSprite();

        const sprite = new Sprite(this.getTransform(), img);
        sprite.refresh = this.refresh;

        this.id[masks.sprite] = this.ecs.id.sprite;
        this.ecs.id.sprite++

        this.layout |= masks.sprite;
        this.ecs.sprites[this.id[masks.sprite]] = sprite;
        return sprite;
    }

    addAnimSprite(): AnimSprite {
        if (this.layout & masks.animsprite)
            return this.getAnimSprite()

        const animsprite = new AnimSprite(this.getTransform());
        animsprite.refresh = this.refresh;

        this.id[masks.animsprite] = this.ecs.id.animSprite;
        this.ecs.id.animSprite++;

        this.layout |= masks.animsprite;
        this.ecs.animsprites[this.id[masks.animsprite]] = animsprite;
        return animsprite;
    }

    addColoredRectangle(width: number = 0.0, height: number = 0.0, color: number = 0xFFFFFF): ColoredRectangle {
        if (this.layout & masks.coloredRec)
            return this.getColoredRectangle()

        const rectangle = new ColoredRectangle(
            this.getTransform(),
            width,
            height,
            color
        );
        rectangle.refresh = this.refresh;

        this.id[masks.coloredRec] = this.ecs.id.coloredRec;
        this.ecs.id.coloredRec++;

        this.layout |= masks.coloredRec;
        this.ecs.coloredRecs[this.id[masks.coloredRec]] = rectangle;
        return rectangle;
    }

    addPanel(img: LoaderResource, leftWidth: number = 0.0, topHeight: number = 0.0, rightWidth: number = 0.0, bottomHeight: number = 0.0): Panel {
        if (this.layout & masks.panel)
            return this.getPanel(img)

        const panel = new Panel(this.getTransform(), img);
        panel.refresh = this.refresh;

        this.id[masks.panel] = this.ecs.id.panel;
        this.ecs.id.panel++;

        this.layout |= masks.panel;
        this.ecs.panels[this.id[masks.panel]] = panel;
        return panel;
    }

    // Removers
    remText(): void {
        if (this.layout & masks.text) {
            this.ecs.texts[this.id[masks.text]].remStage();

            delete this.ecs.texts[this.id[masks.text]];
            this.layout &= (~masks.text);
        }
    }

    remSprite(): void {
        if (this.layout & masks.sprite) {
            this.ecs.sprites[this.id[masks.sprite]].remStage();

            delete this.ecs.sprites[this.id[masks.sprite]];
            this.layout &= (~masks.sprite);
        }
    }

    remAnimSprite(): void {
        if (this.layout & masks.animsprite) {
            this.ecs.animsprites[this.id[masks.animsprite]].remStage();
            
            delete this.ecs.animsprites[this.id[masks.animsprite]]
            this.layout &= (~masks.animsprite);
        }
    }

    remColoredRectangle(): void {
        if (this.layout & masks.coloredRec) {
            this.ecs.coloredRecs[this.id[masks.coloredRec]].remStage();
            
            delete this.ecs.coloredRecs[this.id[masks.coloredRec]]
            this.layout &= (~masks.coloredRec);
        }
    }

    remPanel(): void {
        if (this.layout & masks.panel) {
            this.ecs.panels[this.id[masks.panel]].remStage();
            
            delete this.ecs.panels[this.id[masks.panel]]
            this.layout &= (~masks.panel);
        }
    }

    destroy(): void {
        this.ecs.deleteEntity(this.id);
    }

};

export { ECS, Entity };
