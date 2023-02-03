import { ParticipantDetails, ScheduledGame } from "./Strapi";

export function mockGame(): ScheduledGame {
    const gameDate = new Date();
    gameDate.setSeconds(gameDate.getSeconds() + 300);

    return {
        id: 1,
        game_date: gameDate.toISOString(),
        published_at: new Date().toISOString(),
        created_at: new Date().toISOString(),
        updated_at: new Date().toISOString(),
        scheduled_game_participants: [
            {
                id: 1,
                nft_id: "1",
                user_address: "1",
                name: "test",
                scheduled_game: 1,
                published_at: new Date().toISOString(),
                created_at: new Date().toISOString(),
                updated_at: new Date().toISOString()
            }
        ]
    };
}

export function mockParticipantDetails(): ParticipantDetails {
    return {
        name: "1",
        description: "1",
        image: "",
        dna: "1",
        edition: 1,
        date: 1,
        spritesheet: "1",
        attributes: [
            {
                trait_type: "a",
                value: 1
            }
        ]
    };
}
