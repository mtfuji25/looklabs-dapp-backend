import { CONTAINER_DIM } from "../constants/constants";
import { Vec2 } from "./math";

const wordToView = (pos: Vec2) => {
    return {
        x: (pos.x * CONTAINER_DIM + CONTAINER_DIM) / 2.0,
        y: CONTAINER_DIM - (pos.y * CONTAINER_DIM + CONTAINER_DIM) / 2.0
    }
}

const viewToWord = (pos: Vec2) => {
    return {
        x: (pos.x / CONTAINER_DIM * 2.0) - 1.0,
        y: ((CONTAINER_DIM - pos.y) / CONTAINER_DIM * 2.0) - 1.0
    }
}

const resToNdc = (res: Vec2) => {
    return {
        x: (res.x / CONTAINER_DIM) * 2.0,
        y: (res.y / CONTAINER_DIM) * 2.0
    }
}

const ndcToRes = (ndc: Vec2) => {
    return {
        x: (ndc.x * CONTAINER_DIM) / 2.0,
        y: (ndc.y * CONTAINER_DIM) / 2.0
    }
}

export { wordToView, viewToWord, resToNdc, ndcToRes };