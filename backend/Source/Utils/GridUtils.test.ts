import { Grid } from "../Core/Ecs/Components/Grid";
import { GridUtils } from "./GridUtils";
import { Vec2 } from "./Math";

describe("GridUtils", () => {
    describe("convertCellToPos & convertPosToCell", () => {
        test("A cell converted to pos and then converted to cell again should be equal as before.", () => {
            const grid = new Grid(116, 116);

            const cells = [
                new Vec2(2, 2),
                new Vec2(9, 71),
                new Vec2(88, 51),
                new Vec2(77, 77),
                new Vec2(100, 48),
                new Vec2(92, 84)
            ];

            cells.forEach((cell) => {
                const pos = GridUtils.convertCellToPos(cell, grid);
                const newCell = GridUtils.convertPosToCell(pos, grid);
                expect(cell).toEqual(newCell);
            });
        });
    });

    // describe("convertToNDC & convertFromNDC", () => {
    //     test("A pos converted to NDC and then converted from NDC again should be equal as before.", () => {
    //         const positions = [
    //             new Vec2(0.1, 0.3),
    //             new Vec2(0.7, 0.2),
    //             new Vec2(0.4, 0.4),
    //             new Vec2(0.9, 0.8),
    //         ];

    //         positions.forEach((pos) => {
    //             const ndc = GridUtils.convertToNDC(pos);
    //             const noNdc = GridUtils.convertFromNDC(ndc);
    //             expect(noNdc).toEqual(pos);
    //         });
    //     });
    // });
});
