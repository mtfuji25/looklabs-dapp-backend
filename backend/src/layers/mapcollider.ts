import { ECS, Entity, Grid } from "../core/ecs/core/ecs";
import { Layer } from "../core/layer";
import { GridComponent } from "../core/ecs/components/grid";

import level_collider from "../assets/level_collider.json";

class MapColliderLayer extends Layer {

    constructor(ecs: ECS) {
        super("TesteLayer", ecs);

        this.self.addComponent[Grid](level_collider["width"], level_collider["height"]);
    }

    onAttach() {
        const grid = this.self.getComponent[Grid]() as GridComponent;

        for (let i = 0; i < level_collider["width"]; ++i) {
            for (let j = 0; j < level_collider["height"]; ++j) {
                const collider = level_collider["data"][i][j];
                if (collider !== 0) {
                    grid.addStatic(j, i);
                }
            }
        }
    }

    onUpdate(deltaTime: number) {}

    onDetach() {}
}

export { MapColliderLayer };