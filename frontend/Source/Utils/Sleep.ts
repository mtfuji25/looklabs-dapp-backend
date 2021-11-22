const sleep = (ms: number) => {
    return new Promise((resolve: any) => setTimeout(resolve, ms));
};

const syncSleep = (ms: number) => {
    var start = new Date().getTime();
    for (let i = 0; i < 1e7; i++) {
        if (new Date().getTime() - start > ms) {
            break;
        }
    }
};

export { sleep, syncSleep };
