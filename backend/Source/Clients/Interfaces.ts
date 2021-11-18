import { Vec2 } from "../Utils/Math";

const requests = {
    gameStatus: "game-status"
};

const msgTypes = {
    enemy: "enemy",
    gameStatus: "game-status",
    kill: "kill",
    remainPlayer: "remain-players"
};

interface KillMsg {
    msgType: "kill";
    // tudo que tu precisa
}

interface RemainPlayersMsg {
    msgType: "remain-players";
    // tudo que tuy precisa
}

interface GameStatus {
    msgType: "game-status";
    gameId: number;
    lastGameId: number;
    gameStatus: "lobby" | "awaiting" | "not-found";
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
    attack: number;
    speed: number;
    defense: number;
    cooldown: number;
    maxHealth: number;
    survived: number;
    kills: number;
}

export { requests, msgTypes, GameStatus, PlayerCommand };
