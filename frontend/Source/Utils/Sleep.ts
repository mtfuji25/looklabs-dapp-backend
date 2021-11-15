
const sleep = (ms: number) => {
    return new Promise((resolve: any) => setTimeout(resolve, ms));
};

export { sleep };