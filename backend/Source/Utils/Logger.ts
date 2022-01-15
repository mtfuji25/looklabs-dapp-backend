import { captureException, captureMessage } from "@sentry/node";

const Mask: Record<string, number> = {
    info:       0b000001,
    trace:      0b000010,
    warn:       0b000100,
    error:      0b001000,
    fatal:      0b010000,
    capture:    0b100000,
}

class Logger {

    //
    // Define logs levels actives using a bynary mask
    // Convention: 1 active ; 0 unactive
    // Maks: info / trace / warn / error / fatal
    //
    public static start(level: number) {
        if (!(level & Mask.info)) {
            Logger.info = () => {};
        };
        if (!(level & Mask.trace)) {
            Logger.trace = () => {};
        };
        if (!(level & Mask.warn)) {
            Logger.warn = () => {};
        };
        if (!(level & Mask.error)) {
            Logger.error = () => {};
        };
        if (!(level & Mask.fatal)) {
            Logger.fatal = () => {};
        };
    }

    static info(msg: string, ...args: any[]) {
        console.log(`[ INFO, ${ Date.now() } ]: ${msg}`, ...args);
    }

    static trace(msg: string, ...args: any[]) {
        console.log(`[ TRACE, ${ Date.now() } ]: ${msg}`, ...args);
    }

    static warn(msg: string, ...args: any[]) {
        console.log(`[ WARN, ${ Date.now() } ]: ${msg}`, ...args);
    }

    static error(msg: string, ...args: any[]) {
        console.log(`[ ERROR, ${ Date.now() } ]: ${msg}`, ...args);
    }

    static fatal(msg: string, ...args: any[]) {
        console.log(`*** [ FATAL, ${ Date.now() } ] *** / ${msg}`, ...args);
    }

    static capture(err: Error, msg: string | null = null) {
        captureException(err);

        if (msg) captureMessage(msg);
    }
};

export { Logger };