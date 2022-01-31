import { WebSocket } from "ws";

// Messages types and values

const msgTypes = {
    kill: "kill",
    enemy: "enemy",
    gameStatus: "game-status",
    remainPlayer: "remain-players",
    gameState: "game-state"
};

type MsgTypes = "kill" | "enemy" | "game-status" | "game-state" | "remain-players" | "game-time";
type MsgInterfaces = KillMsg | RemainPlayersMsg | GameStatus |  GameState | PlayerCommand | GameTimeMsg | PlayerNames;
type GameStateTypes = "spawn" | "countdown3" | "countdown2" | "countdown1" | "countdown0" | "fight"
//
//  Msgs interfaces
//

interface KillMsg {
    msgType: "kill";
    killer: string;
    killed: string;
    action: string;
}

interface GameTimeMsg {
    msgType: "game-time",
    hours: string,
    minutes: string, 
    seconds: string
}

interface RemainPlayersMsg {
    msgType: "remain-players";
    totalPlayers: number;
    remainingPlayers: number;
}

interface GameStatus {
    msgType: "game-status";
    gameId: number;
    lastGameId: number;
    gameStatus: "lobby" | "awaiting" | "not-found";
}

interface GameState {
    msgType: "game-state";
    gameId: number;
    gameState: GameStateTypes;
}

interface PlayerNames {
    msgType: "player-names";
    gameId: number;
    names: Record<string, string>;
}

interface PlayerCommand {
    msgType: "enemy";
    type: "create" | "update" | "delete";
    id: string;
    pos: {
        x: number;
        y: number;
    };
    action: number;
    health: number;
}

// Requests types and values

const requests = {
    gameStatus: "game-status",
    playerNames: "player-names",
    gameState: "game-state"
};

type ListenerTypes = "game-status" | "connection" | "player-names" | "game-state";

// Interfaces
interface IncomingMsg {
    uuid: string;
    type: "request";
    content: {
        type: ListenerTypes;
    } & {
        [x: string]: any;
    };
}

interface ServerMsg {
    uuid: string;
    type: "response" | "broadcast" | "send";
    content: KillMsg | PlayerCommand | RemainPlayersMsg | GameStatus | GameState | GameTimeMsg | PlayerNames;
}

interface ReplyableMsg {
    content: {
        type: ListenerTypes;
    } & {
        [x: string]: any;
    };
    reply: (msg: MsgInterfaces) => void;
}

// Listeners
// Callback types
type OnConnectionFn = (event: WebSocket) => boolean;
type OnGameStatusFn = (event: ReplyableMsg) => boolean;
type OnPlayerNamesFn = (event: ReplyableMsg) => boolean;
type OnGameStateFn = (event: ReplyableMsg) => boolean;

type OnListenerFns = OnConnectionFn | OnGameStatusFn | OnGameStateFn;

type msgHandlerFn = (data: IncomingMsg, client: WebSocket) => void;

// Listener types
interface Listener {
    type: ListenerTypes;
    callback: OnListenerFns;
    destroy: () => void;
    id: string;
}

interface GameStatusListener extends Listener {
    callback: OnGameStatusFn;
}

interface GameStateListener extends Listener {
    callback: OnGameStateFn;
}


interface PlayerNamesListener extends Listener {
    callback: OnPlayerNamesFn;
}

interface OnConnectionListener extends Listener {
    callback: OnConnectionFn;
}


export {
    requests,
    msgTypes,
    ListenerTypes,
    MsgTypes,
    ServerMsg,
    GameStatus,
    GameState,
    PlayerNames,
    GameTimeMsg,
    PlayerCommand,
    IncomingMsg,
    ReplyableMsg,
    Listener,
    GameStatusListener,
    GameStateListener,
    PlayerNamesListener,
    OnPlayerNamesFn,
    OnConnectionListener,
    OnListenerFns,
    OnGameStatusFn,
    OnGameStateFn,
    OnConnectionFn,
    msgHandlerFn,
    MsgInterfaces,
    GameStateTypes
};
