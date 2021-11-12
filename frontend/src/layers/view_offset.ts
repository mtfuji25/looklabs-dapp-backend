import { Layer } from "../core/layer";
import { ECS } from "../core/ecs/core/ecs";
import { BTNS, Inputs } from "../core/inputs/inputs";

// Required fields for view layer
interface ViewContext {
    zoom: number;
    offsetX: number;
    offsetY: number;
};

class ViewLayer extends Layer {

    // Zoom controls
    private zoom: number = 0.0;
    private lastZoom: number = 0.0;

    // In game offsets
    private offsetX: number = 0.0;
    private offsetY: number = 0.0;
    private lastX: number = 0.0;
    private lastY: number = 0.0;

    // Controle if was pressed
    private pressed: boolean = false;

    // Inputs
    private inputs: Inputs;

    // Current Level context
    private view: ViewContext;

    constructor(ecs: ECS, viewContext: ViewContext, inputs: Inputs) {
        super("TesteLayer", ecs);

        this.inputs = inputs;
        this.view = viewContext;
    }

    onAttach() {
        this.lastX = this.inputs.cursor.x;
        this.lastY = this.inputs.cursor.y;
        this.lastZoom = this.inputs.wheel;
    }

    onUpdate(deltaTime: number) {
        let localOffX = 0.0;
        let localOffY = 0.0;
    
        if (this.inputs.btn[BTNS.LEFT]) {
            if (!this.pressed) {
                this.lastX = this.inputs.cursor.x;
                this.lastY = this.inputs.cursor.y;
    
                this.pressed = true;
            }
            localOffX = this.inputs.cursor.x - this.lastX;
            localOffY = this.inputs.cursor.y - this.lastY;
    
        } else {
            if (this.pressed) {
                this.offsetX += this.inputs.cursor.x - this.lastX;
                this.offsetY += this.inputs.cursor.y - this.lastY;
            }
    
            this.pressed = false;
        }
    
        this.zoom += this.inputs.wheel - this.lastZoom;
        this.lastZoom = this.inputs.wheel;
    
        if (this.zoom < -10.0) this.zoom = -10.0;
        if (this.zoom >  5.0) this.zoom =  5.0;
    
        this.view.zoom = this.zoom / 25.0;
        this.view.offsetX = this.offsetX + localOffX;
        this.view.offsetY = this.offsetY + localOffY;
    }

    onDetach() {
        this.self.destroy();
    }
};

export { ViewLayer, ViewContext };
