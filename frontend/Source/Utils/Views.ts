import { CONTAINER_DIM_X, CONTAINER_DIM_Y } from "../Constants/Constants";
import { Vec2 } from "./Math";

const wordToView = (pos: Vec2) => {
    return new Vec2(
        (pos.x * CONTAINER_DIM_X + CONTAINER_DIM_X) / 2.0,
        CONTAINER_DIM_Y - (pos.y * CONTAINER_DIM_Y + CONTAINER_DIM_Y) / 2.0
    );
}

const viewToWord = (pos: Vec2) => {
    return new Vec2(
        (pos.x / CONTAINER_DIM_X * 2.0) - 1.0,
        ((CONTAINER_DIM_Y - pos.y) / CONTAINER_DIM_Y * 2.0) - 1.0
    );
}

const resToNdc = (res: Vec2) => {
    return new Vec2(
        (res.x / CONTAINER_DIM_X) * 2.0,
        (res.y / CONTAINER_DIM_Y) * 2.0
    );
}

const ndcToRes = (ndc: Vec2) => {
    return new Vec2(
        (ndc.x * CONTAINER_DIM_X) / 2.0,
        (ndc.y * CONTAINER_DIM_Y) / 2.0
    )
}

export { wordToView, viewToWord, resToNdc, ndcToRes };