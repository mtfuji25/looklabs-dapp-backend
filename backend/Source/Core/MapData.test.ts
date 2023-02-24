import { getSpawnCell } from "./MapData";

describe("MapData", () => {
    describe("getSpawnCell", () => {
        test("Test 1", () => {
            const result = getSpawnCell([
                [1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1],
                [1, 1, 0, 1, 1],
                [1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1]
            ]);

            expect(result).toEqual({ x: 2, y: 2 });
        });

        test("Test 2", () => {
            const result = getSpawnCell([
                [1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1],
                [1, 1, 1, 1, 1],
                [1, 1, 1, 1, 0],
                [1, 1, 1, 1, 1]
            ]);

            expect(result).toEqual({ x: 3, y: 4 });
        });
    });
});
