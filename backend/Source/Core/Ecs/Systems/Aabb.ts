import { GridUtils } from "../../../Utils/GridUtils";
import { Vec2 } from "../../../Utils/Math";
import { Grid } from "../Components/Grid";
import { Rectangle } from "../Components/Rectangle";
import { Rigidbody } from "../Components/Rigidbody";
import { EcsData } from "../Interfaces";
import { collisionsResults } from "./Grid";

const aabbCheck = (rec1: Rectangle, rec2: Rectangle): boolean => {

    const center1 = rec1.getCenter();
    const center2 = rec2.getCenter();

    if (
        center1.x < center2.x + rec2.width &&
        center1.x + rec1.width > center2.x &&
        center1.y < center2.y + rec2.height &&
        rec1.height + center1.y > center2.y
    ){
        return true;
    }

    return false;
};

const sys_CheckOverlap = (data: EcsData, deltaTime: number): void => {
    // Iterates through all grids in system
    data.grids.map((grid) => {
        for (let i = 0; i < grid.dynamics.length; ++i) {
            if (grid.dynamics[i].entity.getStatus().health <= 0) continue;
            const rec1 = grid.dynamics[i].entity.getRectangle();

            for (let j = i + 1; j < grid.dynamics.length; ++j) {
                if (grid.dynamics[j].entity.getStatus().health <= 0) continue;
                const rec2 = grid.dynamics[j].entity.getRectangle();

                if (aabbCheck(rec1, rec2)) {

                    collisionsResults.push({
                        entity: grid.dynamics[i].entity,
                        other: grid.dynamics[j].entity
                    });

                    const rigidbody = grid.dynamics[i].entity.getRigidbody();
                    const otherRigidbody = grid.dynamics[j].entity.getRigidbody();

                    const transform = grid.dynamics[i].entity.getTransform()
                    const otherTransform = grid.dynamics[j].entity.getTransform()

                    if ((!transform) || (!otherTransform))
                        continue;

                    
                    updateTransform (rigidbody, rigidbody.rectangle.transform.pos.sub( rigidbody.velocity.muls(deltaTime)), grid);
                    updateTransform (otherRigidbody, otherRigidbody.rectangle.transform.pos.sub( otherRigidbody.velocity.muls(deltaTime)), grid);
                }
            }
        }
    });
};

const updateTransform = (rigidbody:Rigidbody, nextPosition:Vec2, grid:Grid) => {
    const position = nextPosition.adds(1.0).divs(2.0);
    position.y = 1 - position.y;

    // Find new index of entity
    const nextIndex = new Vec2(
        Math.floor(position.x / (grid.intervalX / 2.0)),
        Math.floor(position.y / (grid.intervalY / 2.0)),
    );

    if (GridUtils.getCellWalkable(nextIndex.y, nextIndex.x) == 0) {
        rigidbody.rectangle.transform.pos = nextPosition;
    }
}

export { sys_CheckOverlap };