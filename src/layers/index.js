import { PlayerLayer } from "./player";
import { BgLayer } from "./background";
import { BaseMove } from "./base-move";
import { Map } from "./map";
import { Batata } from "./batata";
import { Ui } from "./ui";
import { Teste } from "./teste";

let layers = [];

const initLayers = (app) => {
    // Connect layers to the stack
    layers.push(new BaseMove(app));
    //layers.push(new BgLayer(app));
    //layers.push(new PlayerLayer(app));
    //layers.push(new Map(app));
    //layers.push(new Batata(app));

    let teste = new Teste(app);
    let teste2 = new Teste(app);
    let teste3 = new Teste(app);
    let teste4 = new Teste(app);

    layers.push(teste);
    layers.push(teste2);
    layers.push(teste3);
    layers.push(teste4);

    let ui = new Ui(app, teste.getUiStatus, teste2.getUiStatus, teste3.getUiStatus, teste4.getUiStatus);
    layers.push(ui);

    // Call onAttach method
    layers.forEach((layer) => {
        layer.onAttach();
    });
}

export { initLayers, layers };