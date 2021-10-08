import { CONTAINER_DIM } from "../constants/constants";

const wordToView = (pos, props) => {
    return {
        x: (pos.x * CONTAINER_DIM + CONTAINER_DIM) / 2.0,
        y: CONTAINER_DIM - (pos.y * CONTAINER_DIM + CONTAINER_DIM) / 2.0
    }
}

const viewToWord = (pos, props) => {
    return {
        x: (pos.x / CONTAINER_DIM * 2.0) - 1.0,
        y: ((CONTAINER_DIM - pos.y) / CONTAINER_DIM * 2.0) - 1.0
    }
}

const resToNdc = (res, props) => {
    return {
        x: (res.x / CONTAINER_DIM) * 2.0,
        y: (res.y / CONTAINER_DIM) * 2.0
    }
}

const ndcToRes = (ndc, props) => {
    return {
        x: (ndc.x * CONTAINER_DIM) / 2.0,
        y: (ndc.y * CONTAINER_DIM) / 2.0
    }
}

export { wordToView, viewToWord, resToNdc, ndcToRes };