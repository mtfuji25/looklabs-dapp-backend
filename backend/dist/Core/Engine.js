"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g;
    return g = { next: verb(0), "throw": verb(1), "return": verb(2) }, typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (_) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.Engine = void 0;
var Default_1 = require("../Levels/Default");
// Utils imports
var Sleep_1 = require("../Utils/Sleep");
var Engine = /** @class */ (function () {
    function Engine(wsClient, strapiClient) {
        this.wsClient = wsClient;
        this.strapiClient = strapiClient;
        this.context = {
            engine: this,
            ws: this.wsClient,
            strapi: this.strapiClient,
            stats: {
                dt: 0.0,
                fps: 0.0,
                start: Date.now(),
            },
            close: false
        };
        // Make new instance of default level as current
        this.level = new Default_1.DefaultLevel(this.context);
    }
    Engine.prototype.start = function () {
        console.log("Starting backend engine.");
        // Start engine Web Socket client
        this.wsClient.start();
        // Start strapi client
        this.strapiClient.start();
        // Finally load the default level
        console.log("Loading level: ", this.level.getName());
        this.level.onStart();
    };
    Engine.prototype.loop = function () {
        return __awaiter(this, void 0, void 0, function () {
            var current;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        console.log("Entering main engine loop");
                        _a.label = 1;
                    case 1:
                        if (!!this.context.close) return [3 /*break*/, 3];
                        current = Date.now();
                        this.context.stats.dt = (current - this.context.stats.start) / 1000.0;
                        this.context.stats.start = current;
                        this.context.stats.fps = 1.0 / this.context.stats.dt;
                        // Run update fn of current level
                        this.level.onUpdate(this.context.stats.dt);
                        // Run systems pendings
                        this.level.runPendings(this.context.stats.dt);
                        console.log(this.context.stats.fps);
                        return [4 /*yield*/, (0, Sleep_1.sleep)(15)];
                    case 2:
                        _a.sent();
                        return [3 /*break*/, 1];
                    case 3: return [2 /*return*/];
                }
            });
        });
    };
    Engine.prototype.close = function () {
        console.log("Closing backend engine.");
        // Close current active level
        this.closeLevel(this.level);
        // Close strapi client
        this.strapiClient.close();
        // Close engine Web Socket client
        this.wsClient.close();
    };
    Engine.prototype.loadLevel = function (level) {
        // First close the current running level
        this.closeLevel(this.level);
        console.log("Loading level: ", level.getName());
        // Set level as current in context
        this.level = level;
        // Start level and put it to run
        level.onStart();
    };
    Engine.prototype.closeLevel = function (level) {
        console.log("Closing level: ", level.getName());
        // Close all level's systems
        level.closeSystems();
        // Fire the onClose function on current level
        level.onClose();
    };
    return Engine;
}());
exports.Engine = Engine;
;
