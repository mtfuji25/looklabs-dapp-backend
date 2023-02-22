import { AStarFinder } from "./astar-finder";
import tests from "./astar-finder.test.json";

describe("AStarFinder", () => {
    describe("findPath", () => {
        tests.forEach((t, i) => {
            test(`Test ${i}`, () => {
                const finder = new AStarFinder({
                    grid: {
                        matrix: t.matrix
                    },
                    diagonalAllowed: false,
                    includeStartNode: true,
                    includeEndNode: true
                });

                const path = finder.findPath(t.from, t.to);

                console.log(JSON.stringify(path))
                expect(path).toEqual(t.expectedPath);
            });
        });
    });
});
