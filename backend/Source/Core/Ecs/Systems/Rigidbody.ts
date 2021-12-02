import { assert } from "console";
import { EcsData } from "../Interfaces";

const sys_UpdatePos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all rigidbodys in system
    data.rigidbodys.forEach((rigidbody) => {
        let transform = rigidbody.rectangle.transform;

        if (!transform)
            return;

        assert(!(isNaN(rigidbody.velocity.x) || isNaN(rigidbody.velocity.y)), `Rigidibody: ${rigidbody} Is NaN`);

        transform.pos.x += rigidbody.velocity.x * deltaTime;
        transform.pos.y += rigidbody.velocity.y * deltaTime;
    });
};

export { sys_UpdatePos };