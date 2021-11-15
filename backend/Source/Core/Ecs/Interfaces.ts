import { Grid } from "./Components/Grid";
import { Rectangle } from "./Components/Rectangle";
import { Transform } from "./Components/Transform";
import { Rigidbody } from "./Components/Rigidbody";

interface EcsData {
    grids: Grid[];
    rectangles: Rectangle[];
    rigidbodys: Rigidbody[];
    transforms: Transform[];
}

export { EcsData };