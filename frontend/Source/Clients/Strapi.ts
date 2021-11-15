import axios, { AxiosInstance, AxiosResponse } from "axios";

interface ScheduledGame {
    id: number;
    game_date: string;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
    scheduled_game_participants: ScheduledGameParticipant[];
}

interface ScheduledGameParticipant {
    id: number;
    nft_id: string;
    user_address: string;
    scheduled_game: number;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

interface GameParticipantsResult {
    scheduled_game_participant: number;
    result: "died" | "won";
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

class StrapiClient {
    
    private host: string;
    private port: number;

    private readonly api: AxiosInstance;
    // any type because ts complains if I use http.server, the correct type
    private expressServer: any;

    constructor(host: string, port: number) {
        this.host = host;
        this.port = port;
        // start axios instance
        this.api = axios.create({
            baseURL: `${this.host}`,
        });
    }

    private async get(url: string): Promise<AxiosResponse> {
        return this.api.get(url);
    }

    private async post(url: string, data: any): Promise<AxiosResponse>  {
        return this.api.post(url, data);
    }

    private async put(url: string): Promise<AxiosResponse>  {
        return this.api.put(url);
    }

    // Creates a result for a participant on strapi. Takes a player and it's result enum(string)
    // async because consistency is not needed immediately
    async createParticipantResult(result: GameParticipantsResult): Promise<AxiosResponse> {
        return this.post("game-participants-results", result);
    }

    // gets the nearest game
    async getNearestGame(): Promise<ScheduledGame>{
        // get current time
        const now = new Date().toISOString();

        // queries scheduled games, where the game happens after current time, and sorts by
        // ascending, so it returns the nearest game;
        return (await this.get(`scheduled-games?game_date_gte=${now}&_sort=game_date:ASC&_limit=1`)).data[0];
    }

    // get chosen game
    async getGameById(id: number): Promise<ScheduledGame> {
        return (await this.get(`scheduled-games/${id}`)).data;
    }

    // Default engine start call
    start(): void {}

    // Default engine close call
    // closes express server
    close(): void {
        console.log("Closing express server.")
        this.expressServer.close();
    }
}

export { StrapiClient, ScheduledGame, ScheduledGameParticipant, GameParticipantsResult };