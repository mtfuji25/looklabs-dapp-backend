// Layer imports
import { Layer } from "../../Core/Layer";

import { ECS, Entity } from "../../Core/Ecs/Core/Ecs";

// Math imports
import { Vec2 } from "../../Utils/Math";

// Pixi imports
import { Application, Container, Sprite as PixiSprite } from "pixi.js";

import levelMapFile from "../../Assets/AwaitLevelMap.json";

// Cast to something that typescript can understand
const levelMap: Record<string, any> = levelMapFile;

class BackgroundLayer extends Layer {
    // Entities storage
    protected entities: Entity[] = [];

    // Map container
    protected container: Container;

    // Container dim
    protected dim: Vec2 = new Vec2();

    protected app: Application;
    protected res: Record<string, any>;
    private background:PixiSprite;
    private screenX:number;
    private screenY:number;
    private spriteX:number;
    private spriteY:number;

    constructor(ecs: ECS, app: Application, resource: Record<string, any>) {
        super("TesteLayer", ecs);

        this.app = app;
        this.res = resource;

        this.background = new PixiSprite(this.app.loader.resources["notfound-bg"].texture );
        
        
        this.screenX = this.app.view.clientWidth;
        this.screenY = this.app.view.clientHeight;
        
        this.container = new Container();
    }
    loadBackground () {
        this.app.stage.addChild(this.container);
        this.spriteX = this.background.width;
        this.spriteY = this.background.height;
        this.container.addChild(this.background);
    }
   
    onAttach() {
        this.loadBackground();
        this.resize();
    }

    resize () {
        let scale = 1.0;

        if (this.screenX >= this.screenY) {
            scale = this.screenX/this.spriteX;
            if (this.background.height * scale < this.screenY) {
                scale = this.screenY/this.spriteY;
            }
            
        } else {
            scale = this.screenY/this.spriteY;
            if (this.background.width * scale < this.screenX) {
                scale = this.screenX/this.spriteX;
            }
        }
        
        this.background.scale.x = scale;
        this.background.scale.y = scale;

        this.background.x = (this.app.view.clientWidth - this.background.width) * 0.5;
        this.background.y = (this.app.view.clientHeight - this.background.height) * 0.5;
        
    }

    onUpdate(deltaTime: number) {
        if(this.app.view.clientWidth !== this.screenX || this.app.view.clientHeight !== this.screenY) {
            this.screenX = this.app.view.clientWidth;
            this.screenY = this.app.view.clientHeight;

            this.resize();
        }
    }

    onDetach() {
        this.container.removeChild(this.background);
        this.app.stage.removeChild(this.container);
    }
}

export { BackgroundLayer };