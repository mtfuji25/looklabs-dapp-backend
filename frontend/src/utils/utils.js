const wordToView = (pos, props) => {
    return {
        x: (pos.x * props.width + props.width) / 2.0,
        y: props.height - (pos.y * props.height + props.height) / 2.0
    }
}

const viewToWord = (pos, props) => {
    return {
        x: (pos.x / props.width * 2.0) - 1.0,
        y: ((props.height - pos.y) / props.height * 2.0) - 1.0
    }
}

const resToNdc = (res, props) => {
    return {
        x: (res.x / props.width) * 2.0,
        y: (res.y / props.height) * 2.0
    }
}

const ndcToRes = (ndc, props) => {
    return {
        x: (ndc.x * props.width) / 2.0,
        y: (ndc.y * props.height) / 2.0
    }
}

export { wordToView, viewToWord, resToNdc, ndcToRes };