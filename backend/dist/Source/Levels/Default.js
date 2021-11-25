"use strict";
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (Object.prototype.hasOwnProperty.call(b, p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        if (typeof b !== "function" && b !== null)
            throw new TypeError("Class extends value " + String(b) + " is not a constructor or null");
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();
Object.defineProperty(exports, "__esModule", { value: true });
exports.DefaultLevel = void 0;
// Level imports
var Level_1 = require("../Core/Level");
var Await_1 = require("./Await");
var DefaultLevel = /** @class */ (function (_super) {
    __extends(DefaultLevel, _super);
    function DefaultLevel() {
        return _super !== null && _super.apply(this, arguments) || this;
    }
    DefaultLevel.prototype.onStart = function () {
        this.context.engine.loadLevel(new Await_1.AwaitLevel(this.context, "Awaiting"));
    };
    DefaultLevel.prototype.onUpdate = function (deltaTime) { };
    DefaultLevel.prototype.onClose = function () { };
    return DefaultLevel;
}(Level_1.Level));
exports.DefaultLevel = DefaultLevel;
;
