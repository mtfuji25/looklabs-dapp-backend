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
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.StrapiClient = void 0;
var axios_1 = __importDefault(require("axios"));
var express_1 = __importDefault(require("express"));
var StrapiClient = /** @class */ (function () {
    function StrapiClient(host, port, expressHost, expressPort) {
        this.msgListeners = [];
        this.hookListeners = [];
        this.expressApp = (0, express_1.default)();
        // start axios instance
        this.api = axios_1.default.create({
            baseURL: "https://thepit-strapi-3fiy6wgliq-nw.a.run.app/",
        });
        // start express server
        this.startExpressServer(expressPort);
    }
    StrapiClient.prototype.get = function (url) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.api.get(url)];
            });
        });
    };
    StrapiClient.prototype.post = function (url, data) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.api.post(url, data)];
            });
        });
    };
    StrapiClient.prototype.put = function (url) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.api.put(url)];
            });
        });
    };
    // starts express server
    StrapiClient.prototype.startExpressServer = function (expressPort) {
        var _this = this;
        // route for the webhook that sends when a game is scheduled
        this.expressApp.post("/scheduled-games", function (req, res) {
            _this.getNearestGame().then(function (data) {
                // data represents the nearest game
                for (var _i = 0, _a = _this.msgListeners; _i < _a.length; _i++) {
                    var listener = _a[_i];
                    if (listener(data))
                        break;
                }
                for (var _b = 0, _c = _this.hookListeners; _b < _c.length; _b++) {
                    var hook = _c[_b];
                    hook(data);
                }
                _this.hookListeners = [];
            });
            res.sendStatus(200);
        });
        // listen on port x
        this.expressServer = this.expressApp.listen(expressPort, function () {
            console.log("Express listening on port: ", expressPort);
        });
    };
    // Creates a result for a participant on strapi. Takes a player and it's result enum(string)
    // async because consistency is not needed immediately
    StrapiClient.prototype.createParticipantResult = function (result) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                return [2 /*return*/, this.post("game-participants-results", result)];
            });
        });
    };
    // gets the nearest game
    StrapiClient.prototype.getNearestGame = function () {
        return __awaiter(this, void 0, void 0, function () {
            var now;
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0:
                        now = new Date().toISOString();
                        return [4 /*yield*/, this.get("scheduled-games?game_date_gte=" + now + "&_sort=game_date:ASC&_limit=1")];
                    case 1: 
                    // queries scheduled games, where the game happens after current time, and sorts by
                    // ascending, so it returns the nearest game;
                    return [2 /*return*/, (_a.sent()).data[0]];
                }
            });
        });
    };
    // get chosen game
    StrapiClient.prototype.getGameById = function (id) {
        return __awaiter(this, void 0, void 0, function () {
            return __generator(this, function (_a) {
                switch (_a.label) {
                    case 0: return [4 /*yield*/, this.get("scheduled-games/" + id)];
                    case 1: return [2 /*return*/, (_a.sent()).data];
                }
            });
        });
    };
    // Default engine start call
    StrapiClient.prototype.start = function () { };
    // Default engine close call
    // closes express server
    StrapiClient.prototype.close = function () {
        console.log("Closing express server.");
        this.expressServer.close();
    };
    StrapiClient.prototype.onWebhook = function (fn) {
        this.hookListeners.push(fn);
    };
    StrapiClient.prototype.addMsgListener = function (fn) {
        this.msgListeners.push(fn);
        return this.msgListeners.length - 1;
    };
    StrapiClient.prototype.remMsgListener = function (id) {
        this.msgListeners.splice(id, 1);
    };
    return StrapiClient;
}());
exports.StrapiClient = StrapiClient;