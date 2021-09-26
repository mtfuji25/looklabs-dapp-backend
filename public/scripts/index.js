window.onload = () => {
    let app = new PIXI.Application({
        width: innerWidth - 10,
        height: innerHeight - 10,
        resolution: devicePixelRatio,
        backgroundColor: 0xAAAAAA
    });

    document.querySelector("#root").appendChild(app.view);
};