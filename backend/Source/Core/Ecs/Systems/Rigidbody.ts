import { EcsData } from "../Interfaces";

const sys_UpdatePos = (data: EcsData, deltaTime: number): void => {
    // Iterates through all rigidbodys in system
    data.rigidbodys.forEach((rigidbody) => {
        let transform = rigidbody.rectangle.transform;

        if (!transform)
            return;
        transform.pos.x += rigidbody.velocity.x * deltaTime;
        transform.pos.y += rigidbody.velocity.y * deltaTime;
    });
};

export { sys_UpdatePos };