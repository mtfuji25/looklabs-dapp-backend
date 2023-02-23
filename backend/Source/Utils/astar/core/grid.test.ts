import { Grid } from "./grid";

describe("Grid", () => {
    describe("isWalkableAt", () => {
        test("Test 1", () => {
            const matrix = [
                [0, 0, 0, 0, 0],
                [0, 0, 1, 0, 0],
                [0, 1, 1, 1, 0],
                [0, 0, 1, 0, 0],
                [0, 0, 0, 0, 0]
            ];

            const grid = new Grid({ width: 5, height: 5, matrix });

            expect(grid.isWalkableAt({ x: 0, y: 0 })).toBe(true);
            expect(grid.isWalkableAt({ x: 2, y: 1 })).toBe(false);
        });
    });
});