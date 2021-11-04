
import { Layer } from "./layer";

class LayerStack {
    layers: Layer[] = [];
    insertIndex: number = 0;

    pushLayer(layer: Layer): void {
        this.layers.splice(this.insertIndex, 0, layer);
        this.insertIndex++;
        layer.onAttach();
    }

    pushOverlay(overlay: Layer): void {
        this.layers.push(overlay);
        overlay.onAttach();
    }

    popLayer(layer: Layer): void {
        layer.onDetach();
        this.layers = this.layers.filter(item => item !== layer);
        this.insertIndex--;
    }
    
    popOverlay(overlay: Layer): void {
        overlay.onDetach();
        this.layers = this.layers.filter(item => item !== overlay);
    }

    destroy(): void {
        this.layers.map((layer: Layer) => {
            layer.onDetach();
        });

        this.layers = []
    }
}

export { LayerStack };