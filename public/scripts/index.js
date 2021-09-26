//
// Assets directories
//

const ICON_DIR = "../assets/icons/";
const IMAGE_DIR = "../assets/images/";
const SPRITE_DIR = "../assets/sprites/";

// Constants
const ROOT_DIV = document.querySelector("#root");

// In game used key codes

const KEY_CODE = {
    KEY_W: 87,
    KEY_S: 83,
    KEY_A: 65,
    KEY_D: 68,
    KEY_SPACE: 32,
};

//
//  Handled by PIXI
//
const handlePointerMove = (event) => {
    
}

//
// Handled by default browser event system
//

const handleKeyUp = (event) => {
    console.log(event);
};

const handleKeyDown = (event) => {
    console.log(event);
};

const handleMouseBtnDown = (event) => {
    console.log(event);
};

const handleMouseBtnUp = (event) => {
    console.log(event);
};

const handleMouseWheel = (event) => {
    let up = (event.wheelDelta > 0) ? true : false;

    up ? console.log("is up") : console.log("is down");
};

window.onload = () => {
    let app = new PIXI.Application({
        resolution: devicePixelRatio,
        backgroundColor: 0xAAAAAA,
        resizeTo: ROOT_DIV
    });

    ROOT_DIV.appendChild(app.view);

    let player = new PIXI.Sprite.from(SPRITE_DIR + "mage.png");
    player.anchor.set(0.5);
    player.x = app.view.width / 2;
    player.y = app.view.height / 2;

    app.stage.addChild(player);

    // Allow the interactive mode of PIXI
    app.stage.interactive = true;

    // Set the PIXI event listener
    app.stage.on("pointermove", handlePointerMove);

    // Set the browser event listeners
    window.addEventListener("keydown", handleKeyDown);
    window.addEventListener("keyup", handleKeyUp);
    window.addEventListener("mousedown", handleMouseBtnDown);
    window.addEventListener("mouseup", handleMouseBtnUp);
    window.addEventListener("wheel", handleMouseWheel);
};