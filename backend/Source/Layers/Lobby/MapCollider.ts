// Layer import
import { Layer } from "../../Core/Layer";

// Ecs import
import { ECS } from "../../Core/Ecs/Core/Ecs";

// Map importing
import levelCollider from "../../Assets/level_collider.json";

class MapColliderLayer extends Layer {

    constructor(ecs: ECS) {
        super("MapCollider", ecs);

        this.self.addGrid(
            levelCollider["width"],
            levelCollider["height"]
        );
    }

    onAttach() {
        const grid = this.self.getGrid();

        for (let i = 0; i < levelCollider["width"]; ++i) {
            for (let j = 0; j < levelCollider["height"]; ++j) {
                const collider = levelCollider["data"][i][j];
                if (collider !== 0) {
                    grid.addStatic(i, j);
                }
            }
        }
    }

    onUpdate(deltaTime: number) {}

    onDetach() {
        this.self.destroy();
    }
};

export { MapColliderLayer };