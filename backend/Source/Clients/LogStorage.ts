import { Datastore } from "@google-cloud/datastore";

const KEY_KIND = "log";

interface Log {
    event: "entrants" | "damage" | "kills" | "winners" | "final_rank";
    value?: number;
    timestamp: number;
    scheduled_game: number;
    scheduled_game_participant: number;
};

class LogStorageClient {
    
    private connection: Datastore;

    constructor(projectId: string) {
        this.connection = new Datastore({
            projectId: projectId ?? null,
        });
    }

    async createLog(log: Log) {
        const key = this.connection.key(KEY_KIND);

        await this.connection.upsert({
            key: key,
            data: log
        });
    }

    async start() {}

    async close() {}
}

export { LogStorageClient, Log };
