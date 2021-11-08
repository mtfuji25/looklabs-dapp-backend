
import { InteractionEvent, Application } from "pixi.js";

// Keys definitions
const KEYS = {
    // Player controls
    W: 87, S: 83, A: 65, D: 68,

    // Generic selectors
    ONE: 49, TWO: 50, THREE: 51, FOUR: 52, FIVE: 53,

    // Mechanics controls
    ESC: 27, SPACE: 32, L_SHIFT: 16, L_CTRL: 17,
}

// Mouse definitions
const BTNS = {
    LEFT: 0, MIDDLE: 1, RIGHT: 2
}

interface Inputs {
    key: Record<number, boolean>;
    btn: Record<number, boolean>;
    wheel: number;
    cursor: { x: number, y: number };
};

// Current inputs
const inputs: Inputs = {
    key: {},
    btn: {},
    wheel: 0,
    cursor: {
        x: 0,
        y: 0,
    }
};

//
//  Handled by PIXI
//
const handlePointerMove = (event: InteractionEvent) => {
    let pos = event.data.global;

    inputs.cursor.x = pos.x;
    inputs.cursor.y = pos.y;
};

//
//  Handled by default browser event system
//

//  When some key is pressed down
const handleKeyDown = (event: KeyboardEvent) => {
    inputs.key[event.keyCode] = true;
};

//  When some key is released up
const handleKeyUp = (event: KeyboardEvent) => {
    inputs.key[event.keyCode] = false;
};

//  When some button is pressed down
const handleMouseBtnDown = (event: MouseEvent) => {
    inputs.btn[event.button] = true;
};

//  When some button is released up
const handleMouseBtnUp = (event: MouseEvent) => {
    inputs.btn[event.button] = false;
};

//  When mouse wheel is activated
const handleMouseWheel = (event: WheelEvent) => {
    inputs.wheel += (event.deltaY < 0) ? -1 : 1;
};

const initInputs = (app: Application) => {
    // Start the event listerner of the PIXI application,
    // it will be triggered when the cursor moves in the canvas
    app.stage.on("pointermove", handlePointerMove);

    // Remove the default behavior of browser of open contextmenu
    // when right mouse button is pressed on page
    document.addEventListener("contextmenu", (event) => {
        event.preventDefault();
    }, false);

    // Set the browser event listeners
    window.addEventListener("keydown", handleKeyDown);
    window.addEventListener("keyup", handleKeyUp);
    window.addEventListener("mousedown", handleMouseBtnDown);
    window.addEventListener("mouseup", handleMouseBtnUp);
    window.addEventListener("wheel", handleMouseWheel);
}

export { KEYS, BTNS, inputs, initInputs };
