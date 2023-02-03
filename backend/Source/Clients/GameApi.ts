import axios, { AxiosInstance, AxiosResponse, AxiosError } from "axios";

export interface ScheduledGame {
    id: number;
    game_date: string;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
    max_participants?: number;
    scheduled_game_participants: ScheduledGameParticipant[];
}

export interface ScheduledGameParticipant {
    id: number;
    nft_id: string;
    user_address: string;
    name: string;
    scheduled_game: number;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

export interface GameParticipantsResult {
    scheduled_game_participant: number;
    survived_for: number;
    kills: number;
    health: number;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

// Return value for rest api
export interface ParticipantDetails {
    name: string;
    description: string;
    image: string;
    dna: string;
    edition: number;
    date: number;
    spritesheet: string;
    attributes: DetailAttribute[];
}

// Attributes of a detail
export interface DetailAttribute {
    trait_type: string;
    value: number | string;
}

// Parent class, should not be used directly. Use Strapi or MockedApi instead
export class GameApi {
    protected host: string;

    protected readonly api: AxiosInstance;

    // restApi for player attributes
    protected readonly restApi: AxiosInstance;
    protected readonly authToken: string;

    constructor(host: string, token: string) {
        this.host = host;
        this.authToken = token;
        // start axios instance
        this.api = axios.create({
            baseURL: host
        });

        // start axios for restApi
        this.restApi = axios.create({
            baseURL: "https://token.thepitnft.com/"
        });
    }

    protected async get(url: string): Promise<AxiosResponse> {
        return this.api.get(url, { headers: { Authorization: `bearer ${this.authToken}` } });
    }

    protected async post(url: string, data: any): Promise<AxiosResponse> {
        return this.api.post(url, data, { headers: { Authorization: `bearer ${this.authToken}` } });
    }

    async createParticipantResult(result: GameParticipantsResult): Promise<AxiosResponse> {
        return null as AxiosResponse;
    }

    // gets the nearest game
    async getNearestGame(): Promise<ScheduledGame> {
        return null as ScheduledGame;
    }

    // get chosen game
    async getGameById(id: number): Promise<ScheduledGame> {
        return null as ScheduledGame;
    }

    // get the details for a chosen participant
    async getParticipantDetails(tokenAddr: string, tokenId: string): Promise<ParticipantDetails> {
        return null as ParticipantDetails;
    }

    // Default engine start call
    start(): void {}

    // Default engine close call
    close(): void {}
}
