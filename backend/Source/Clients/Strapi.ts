import axios, { AxiosInstance, AxiosResponse, AxiosError } from "axios";

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
    name: string;
    scheduled_game: number;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

interface GameParticipantsResult {
    scheduled_game_participant: number;
    survived_for: number;
    kills: number;
    health: number;
    published_at?: string;
    created_at?: string;
    updated_at?: string;
}

// Return value for rest api
interface ParticipantDetails {
    name: string;
    description: string;
    image: string;
    dna: string;
    edition: number;
    date: number;
    attributes: DetailAttribute[];
}

// Attributes of a detail
interface DetailAttribute {
    trait_type: string;
    value: number | string;
}

class StrapiClient {
    
    private host: string;

    // strapiApi
    private readonly api: AxiosInstance;

    // restApi for player attributes
    private readonly restApi: AxiosInstance;

    constructor(host: string) {
        this.host = host;
        // start axios instance
        this.api = axios.create({
            baseURL: host,
        })

        // start axios for restApi
        this.restApi = axios.create({
            baseURL: 'https://token.thepitnft.com/contractAddress/',
        })
    }

    private async get(url: string): Promise<AxiosResponse> {
        return this.api.get(url);
    }

    private async post(url: string, data: any): Promise<AxiosResponse>  {
        return this.api.post(url, data);
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

    // get the details for a chosen participant
    async getParticipantDetails(tokenId: number): Promise<ParticipantDetails> {
        return (await this.restApi.get(`${tokenId}`)).data;
    }

    // Default engine start call
    start(): void {}

    // Default engine close call
    close(): void {}
}

export { StrapiClient, ScheduledGame, ScheduledGameParticipant, GameParticipantsResult, ParticipantDetails, DetailAttribute };
