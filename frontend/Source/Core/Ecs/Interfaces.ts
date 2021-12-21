import { Text } from "./Components/Text";
import { Sprite } from "./Components/Sprite";
import { Transform } from "./Components/Transform";
import { AnimSprite } from "./Components/AnimSprite";
import { ColoredRectangle } from "./Components/ColoredRectangle";
import { Panel } from "./Components/Panel";
import { BMPText } from "./Components/BMPText";

interface EcsData {
    texts: Text[];
    bmpTexts: BMPText[];
    sprites: Sprite[];
    transforms: Transform[];
    animsprites: AnimSprite[];
    coloredRecs: ColoredRectangle[];
    panels: Panel[];
}

export { EcsData };