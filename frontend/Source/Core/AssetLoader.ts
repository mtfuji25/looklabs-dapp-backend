import { Application, SCALE_MODES, settings } from "pixi.js";

type Resource = {
    name:string;
    url:string;
}
class AssetLoader {

    private app: Application;
    private assets:Set<string> = new Set();

    constructor (app:Application) {
        this.app = app;
    }

    loadResources (res:Resource[], callBack?:()=>void) {
        res.forEach( asset => {
            if (!this.assets.has(asset.url)) {
                this.app.loader.add(asset);
                this.assets.add(asset.url);
            }
        });
        
        settings.SCALE_MODE = SCALE_MODES.NEAREST;
        this.app.loader.load();
        if (callBack)
            this.app.loader.onComplete.add( callBack );
    }

    loadFromJSON (res:Record<string, any>, callBack?:()=>void) {
        res["packs"].forEach((pack: string) => { 
            const resource:Resource[]= res[pack];
            resource.forEach( asset => {
                if (!this.assets.has(asset.url)) {
                    this.app.loader.add(asset);
                    this.assets.add(asset.url);
                }
            });
        });
        settings.SCALE_MODE = SCALE_MODES.NEAREST;
        this.app.loader.load();
        if (callBack)
            this.app.loader.onComplete.add( callBack );
    }
}

export { AssetLoader, Resource }