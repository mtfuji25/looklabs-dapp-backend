import { ParticipantDetails, ScheduledGame } from "./Strapi";

export function mockGame(): ScheduledGame {
    const gameDate = new Date();
    gameDate.setSeconds(gameDate.getSeconds() + 15);

    return {
        id: 1,
        game_date: gameDate.toISOString(),
        scheduled_game_participants: [
            {
                id: 1,
                nft_id: "0x03dE5D4eA3c9a899F09C56dDD3b1FCAb68af9FED/1",
                user_address: "1",
                name: "1",
                scheduled_game: 1
            },
            {
                id: 2,
                nft_id: "0x03dE5D4eA3c9a899F09C56dDD3b1FCAb68af9FED/2",
                user_address: "2",
                name: "2",
                scheduled_game: 1
            }
        ]
    };
}

export function mockParticipantDetails(): ParticipantDetails {
    return {
        dna: "27010153d2c576e664ca2f565c047afd83ffb2365bd9ab0eee1c62741fdf85d9",
        name: "Wolf Passport",
        description:
            "The PIT is the first game of its kind, and will provide a competitive environment for wagering NFTs against each other in simulated battle, The Kodoku curse ensnares wretched and once human souls before twisting and reshaping them in beastly forms, Avians, Hounds, Insectoids and Serpents are immortalised as NFTs and PITTED against each other in eternal combat, These PIT Creatures are forced to fight for both glory and survival in THE PIT - an infernal Neo-Colosseum floating through the empty and endless void.",
        image: "https://token.thepitnft.com/wolfgame/image.png",
        edition: 1,
        date: 1638910137238,
        attributes: [
            {
                trait_type: "Collection",
                value: "Wolf.game"
            },
            {
                trait_type: "Creature",
                value: "Wolf"
            },
            {
                trait_type: "Attack",
                value: 58
            },
            {
                trait_type: "Defence",
                value: 56
            },
            {
                trait_type: "Speed",
                value: 58
            },
            {
                trait_type: "Health",
                value: 100
            }
        ],
        spritesheet: "blackwolf.png"
    };
}
