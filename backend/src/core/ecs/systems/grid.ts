import { Vec2 } from "../../../utils/math";
import { EcsData } from "../../interfaces";
import { TransformComponent } from "../components/transform";
import { Transform } from "../core/ecs";

const sysUpdateGrid = (data: EcsData, deltaTime: number): void => {
    // Iterates through all grids in system
    data.grids.forEach((grid) => {
        // Just dynamics entitys should be checked
        grid.dynamics.forEach((dynamicEntity) => {
            const transform = dynamicEntity.entity.getComponent[Transform]() as TransformComponent;

            // Changes coordinate sistem from ndc to normalized left-upper origin
            const position = transform.pos.adds(1.0).divs(2.0);
            position.y = 1 - position.y;

            // Find new index of entity
            const index = new Vec2(
                Math.floor(position.x / (grid.intervalX / 2.0)),
                Math.floor(position.y / (grid.intervalY / 2.0)),
            );

            // Update the index in the definition
            dynamicEntity.index = index;
        });
    });
};

export { sysUpdateGrid };