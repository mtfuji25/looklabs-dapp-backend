import { assert } from "console";
import { xor } from "lodash";
import { GridUtils } from "../../../Utils/GridUtils";
import { Vec2 } from "../../../Utils/Math";
import { Grid } from "../Components/Grid";
import { EcsData } from "../Interfaces";

const sys_UpdatePos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all rigidbodys in system
    data.rigidbodys.forEach((rigidbody) => {
        let transform = rigidbody.rectangle.transform;

        if (!transform)
            return;

        assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Rigidibody: ${rigidbody} Is NaN`);

        const nextPosition = new Vec2(transform.pos.x + rigidbody.velocity.x * deltaTime, transform.pos.y + rigidbody.velocity.y * deltaTime);
        
        const position = nextPosition.adds(1.0).divs(2.0);
        position.y = 1 - position.y;

        // Find new index of entity
        const nextIndex = new Vec2(
            Math.floor(position.x / (data.grids[0].intervalX / 2.0)),
            Math.floor(position.y / (data.grids[0].intervalY / 2.0)),
        );

        if (GridUtils.getCellWalkable(nextIndex.y, nextIndex.x) == 0) {
            transform.pos.x = nextPosition.x;
            transform.pos.y = nextPosition.y;
        }
        
    });
};

export { sys_UpdatePos };