

const num_participants = 100;

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
    name: string;
    user_address: string;
    scheduled_game: number;
    game_participants_result: GameParticipantsResult;
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

   
    // any type because ts complains if I use http.server, the correct type
    private expressServer: any;

    constructor(host: string) {
        this.host = host;  
        
    }

    private getParticipants ():ScheduledGameParticipant[] {
        const participants:ScheduledGameParticipant[]   = [];
        let num = num_participants;
		while (num-- > 1) {
			const p:ScheduledGameParticipant = {
                id : num,
                nft_id : uuids[num-1],  		
                user_address : "0.0.0.0",
                scheduled_game : 1,
                name : "Wolf " + num_participants,
                game_participants_result: {
                    scheduled_game_participant: 0,
                    survived_for:0,
                    kills: 0,
                    health: 0,            
                },
                published_at: "",
                created_at: "",
                updated_at: "",
                
            };
			participants.push(p);
		}
        return participants;
    }

    private getGame (): ScheduledGame {
		const now = new Date().toISOString();
		const participants = this.getParticipants();
		const game = {
		id : 1,
		game_date : now,
		scheduled_game_participants : participants
        }
		return game;
    }

    // Creates a result for a participant on strapi. Takes a player and it's result enum(string)
    // async because consistency is not needed immediately
    async createParticipantResult(result: GameParticipantsResult): Promise<String> {
        return Promise.resolve("game-participants-results");
    }

    async getNearestGame(): Promise<ScheduledGame> {
        return Promise.resolve(this.getGame()); 
    }

    // get chosen game
    async getGameById(id: number): Promise<ScheduledGame> {
        return Promise.resolve(this.getGame()); 
    }

    async getGameParticipants(id: number):Promise<ScheduledGameParticipant[]> {
        return Promise.resolve(this.getParticipants()); 
    }

    async getParticipantDetails(tokenId: number): Promise<ParticipantDetails> {
        return Promise.resolve(
            {
                name: "",
                description: "",
                image: "",
                dna: "",
                edition: 1,
                date: 1,
                attributes: []
            }

        ); 
       
    }    


    // Default engine start call
    start(): void {}

    // Default engine close call
    // closes express server
    close(): void {
        console.log("Closing express server.");
        this.expressServer.close();
    }
}


const uuids = ["25d49418-9f08-49a1-b00a-4b7595d7bc30/1",
"06db34e0-184d-4e60-9a5f-039a57bf11f8/2",
"4c6c51c5-26b8-4d9f-b252-41a47057dc60/3",
"356ee7ed-bb14-44cb-8d34-f8a47351e3dd/4",
"f60d9400-a032-48ff-9a3d-34d7e0c1011a/5",
"ab0f3bd7-69fb-4925-bc07-06ef2d0b2444/6",
"815fbe02-8425-4627-9d46-768114f79300/7",
"77545bfc-f359-46d8-9755-5e95d958d523/8",
"629f137e-977f-4372-994f-e4b8801c9b20/9",
"148b2cbf-9ace-432d-94b4-05ff837fb267/10",
"d0563b5b-d637-4575-91ff-b160fc0593ab/11",
"a82c5d1c-af01-4c3d-8b74-cf6439bb19fe/12",
"094d3496-bd60-4101-99a2-3e057cbb8d6a/13",
"6de983bc-81f0-406c-b431-d560eee2bef3/14",
"05ee1391-545b-456a-858a-96a936f3cc3c/15",
"cf011d0b-fdf5-4d83-b690-aef81cb935aa/16",
"deef7df8-34d3-4a3c-9b1c-19371824e729/17",
"809199fe-b1a9-43f8-a7ce-213df824a679/18",
"184e0401-f138-440c-96ca-2bbe3e80157a/19",
"049126d5-f6e7-470c-b65b-1fc274672a58/20",
"4a617d55-f0fc-4824-b701-d67d56b9b72f/21",
"2557706a-949e-43eb-89f5-4ad79c76c4b6/22",
"a3353630-08df-436b-b7dd-4fedd0a5c9a8/23",
"277f162f-4a7a-43c8-9372-f0cd002145b5/24",
"72293b9e-3807-4ecb-a3aa-1f716b20be94/25",
"37ec4898-13b7-4936-aeee-f43c139004ab/26",
"3cbb60ca-2a16-4c0c-9f5d-0c10f7cd678a/27",
"d51f1002-2068-4679-8c8c-99da2ce159a3/28",
"c329c6cf-be40-4bdb-a43f-497c8f45e02d/29",
"45a2059e-607a-44f8-91b8-f6508722cd50/30",
"bc2a0999-c2bc-4b53-be39-b572c5d475ad/31",
"41ec156d-84ca-47e9-a0a3-c8af622d8261/32",
"b81554b7-e826-40b8-a124-308f7b61d6bc/33",
"e2578414-4b11-45a3-9ac8-fb4cf7682a48/34",
"6f7c3d2f-42b2-4092-a45a-7f6623b18610/35",
"8fe9dcc1-b1f4-40cf-8e58-6335ee2a4571/36",
"9a461293-bc4c-4a16-bd07-49b4f41aae96/37",
"d63f3172-a53b-44ef-b002-bc9a4ca1ec7e/38",
"768a3e19-921d-4696-850a-004d3cec7988/39",
"0fea72f1-4abd-4c5a-a55d-c1d90e7a7d6f/40",
"947667b0-1188-46e4-8f81-c0066c85a6bd/41",
"5b845612-7d67-4f77-8817-2f34f4f40bf7/42",
"48a71598-f4ca-4830-a9d7-0f5c0da614d2/43",
"d8dda1ed-ded2-432a-b1e9-7a96c9bdb74d/44",
"896014ea-2d62-43cb-974e-06d9370124cf/45",
"d52f4f4c-3830-424a-b4c5-5f0da0fc7a78/46",
"3ba55c9e-6a01-4cf7-8bc9-92fedf2b6749/47",
"51dbec53-6088-4048-be0e-cb34404ea741/48",
"bd6c28a7-3623-417f-915c-3b012f8ce7d9/49",
"c21b30e5-d546-4c36-ad91-0be43b3b2c06/50",
"92d07d71-c95c-41f8-b2cf-4e43bd60c015/51",
"a19acd4c-51b7-467d-aed5-ad91f3ea858e/52",
"8ff65e29-1150-49b3-b06a-d4a094240527/53",
"f8677be3-24f7-4f83-bf16-0dd1ff72b852/54",
"7c06dede-0b6a-4ad3-b503-938c0c1eada0/55",
"82945492-9e0e-4111-afbd-a232bfccca56/56",
"a17bae8f-6c66-466e-a0de-4969f113409d/57",
"cd15daa6-a760-47ca-829f-7eccf960b37d/58",
"135e55f2-3bd8-48f7-8a07-0bdfafc12dbb/59",
"0878d68b-cefc-4a3a-9b6b-67518cdb2eae/60",
"fe4630c0-7854-4613-8e4f-a207b2a171df/61",
"74b07bd0-cfd4-4bc4-8426-6e7aabd12323/62",
"9fc76199-e40e-4c61-a5a3-e58dc0b180c0/63",
"6ce9ab6d-987b-4434-aaf6-a8c5288b972d/64",
"083800a9-f7a8-4bda-a6d5-3bacade11261/65",
"d3b4f8f1-0e08-4423-8c89-f18e3ef89f86/66",
"0ad184cf-09d2-4d23-acef-1bc39669a277/67",
"994981cb-43ac-4419-9afb-eac4ce33bf97/68",
"b318d4d3-c7f2-45ec-bee2-0ac0d453f371/69",
"27b2a64d-ec32-41e2-9154-77026583112d/70",
"4d32393f-97f4-469a-9784-fb1368a1c63f/71",
"1f3850f1-0ddb-4cd1-9fc5-67323a826f80/72",
"071f74f0-6fb0-42de-92bc-bdbbd68b9ebf/73",
"db4420be-8637-4ace-b073-cf3c7e82736f/74",
"b8625878-6988-4aca-adaa-19e7de8bb403/75",
"b5b8c4cf-81e3-47dc-a000-0568ec82e9bd/76",
"a09e54fe-f730-438b-9c90-fb4cbc0f8cbc/77",
"d64d2564-0c0a-4bfe-8bec-dde962995f22/78",
"6ac38c62-8297-4dc8-8076-514eed837f41/79",
"749e7686-21dc-4709-a5e0-be47537bb7d9/80",
"730eaa93-a18b-4764-bced-100627f45bb7/81",
"e5f1310f-d3bb-4214-8378-e705ac5fc4c1/82",
"d579e56a-b7c2-469e-b003-d65e418d279e/83",
"b35b84ed-69bf-4102-a856-d71119d9d928/84",
"6958e5e9-c8b3-482b-9f0e-e001b1139cb7/85",
"5e8f3b99-5834-41ae-8b37-2744bb32f5bb/86",
"813a1287-0c68-4442-93d2-9b3b2e879337/87",
"3cbfcc3a-3512-4e87-9504-025d459538f6/88",
"920075c5-77bc-47f7-b540-71437ee8f333/89",
"9e880474-bbd7-491c-98f8-1fa7a16a5e66/90",
"23f1ec4e-ddcb-4676-b5be-077ce0f0e969/91",
"3e8b345e-78b4-43b7-bf85-0818720ce836/92",
"315ec099-9680-4061-9404-1fd40764e019/93",
"a7f77d5d-6e0b-4ea7-8e89-dfc94a14d48f/94",
"ed309968-e351-433c-9334-ecc82b6cb203/95",
"ccff0724-cbfa-40c8-a3c6-01cc3ef971f7/96",
"d18d1b74-8b31-424b-a37f-fca73358cb5a/97",
"b68d2809-af4c-4267-81f7-8d2dd2492623/98",
"4fbe1ae2-6133-4906-9210-3e6f3079df38/99",
"7a2af538-c08a-4213-a1b0-04d3f0baea6b/100"];

export { StrapiClient, ScheduledGame, ScheduledGameParticipant, GameParticipantsResult , ParticipantDetails};
