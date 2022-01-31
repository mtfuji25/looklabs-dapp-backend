import { Grid } from "./Components/Grid";
import { Status } from "./Components/Status";
import { Rectangle } from "./Components/Rectangle";
import { Transform } from "./Components/Transform";
import { Rigidbody } from "./Components/Rigidbody";
import { Behavior } from "./Components/Behavior";
import { Strategy } from "./Components/Strategy";
import { Entity } from "./Core/Ecs";
import { Vec2 } from "../../Utils/Math";

interface EcsData {
    grids: Grid[];
    status: Status[];
    behaviors: Behavior[];
    rectangles: Rectangle[];
    rigidbodys: Rigidbody[];
    transforms: Transform[];
    strategies: Strategy[];
}

interface PathData {
    entity:Entity;
    pathIndex:number;
    direction:number;
    path?:Vec2[];
}

export { EcsData, PathData };