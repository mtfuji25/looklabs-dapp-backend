import { AStarFinder } from "./astar-finder";

const tests = [
    {
        matrix: [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
        ],
        from: { x: 0, y: 2 },
        to: { x: 3, y: 2 },
        expectedPath: [
            [0, 2],
            [1, 2],
            [2, 2],
            [3, 2]
        ]
    },
    {
        matrix: [
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 1, 0, 0],
            [0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0]
        ],
        from: { x: 0, y: 2 },
        to: { x: 3, y: 2 },
        expectedPath: [
            [0, 2],
            [1, 2],
            [1, 1],
            [2, 1],
            [3, 1],
            [3, 2]
        ]
    },
    {
        matrix: [
            [0, 0, 0, 0, 0],
            [1, 1, 1, 1, 0],
            [0, 0, 0, 0, 0],
            [0, 1, 1, 1, 1],
            [0, 0, 0, 0, 0]
        ],
        from: { x: 0, y: 0 },
        to: { x: 4, y: 4 },
        expectedPath: [
            [0, 0], [1, 0], [2, 0], [3, 0], [4, 0],
            [4, 1], [4, 2], [3, 2], [2, 2], [1, 2],
            [0, 2], [0, 3], [0, 4], [1, 4], [2, 4],
            [3, 4], [4, 4],
        ]
    },
    {
        matrix: [
            [0, 0, 0, 0, 0],
            [1, 1, 1, 1, 0],
            [0, 0, 1, 0, 0],
            [0, 1, 1, 1, 1],
            [0, 0, 0, 0, 0]
        ],
        from: { x: 0, y: 0 },
        to: { x: 4, y: 4 },
        expectedPath: []
    },
    {
        matrix: [
            [0, 0, 0, 0, 1],
            [0, 0, 0, 1, 0],
            [0, 0, 1, 0, 0],
            [0, 1, 0, 0, 0],
            [1, 0, 0, 0, 0]
        ],
        from: { x: 0, y: 0 },
        to: { x: 4, y: 4 },
        expectedPath: []
    },
];

describe("AStarFinder", () => {
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
            expect(path).toEqual(t.expectedPath);
        });
    });
});
