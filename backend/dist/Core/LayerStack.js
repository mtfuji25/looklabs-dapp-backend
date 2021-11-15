"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.LayerStack = void 0;
var LayerStack = /** @class */ (function () {
    function LayerStack() {
        // Layers list
        this.layers = [];
        // Insert index for overlays
        this.insertIndex = 0;
    }
    LayerStack.prototype.pushLayer = function (layer) {
        this.layers.splice(this.insertIndex, 0, layer);
        this.insertIndex++;
        layer.onAttach();
    };
    LayerStack.prototype.pushOverlay = function (overlay) {
        this.layers.push(overlay);
        overlay.onAttach();
    };
    LayerStack.prototype.popLayer = function (layer) {
        layer.onDetach();
        this.layers = this.layers.filter(function (item) { return item !== layer; });
        this.insertIndex--;
    };
    LayerStack.prototype.popOverlay = function (overlay) {
        overlay.onDetach();
        this.layers = this.layers.filter(function (item) { return item !== overlay; });
    };
    LayerStack.prototype.destroy = function () {
        this.layers.map(function (layer) {
            layer.onDetach();
        });
        this.layers = [];
    };
    return LayerStack;
}());
exports.LayerStack = LayerStack;
