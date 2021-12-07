import os
import argparse

parser = argparse.ArgumentParser(description = "Create game parameters")
parser.add_argument('-A', "--auth", help = "Current bearer token", type = str, required = False, default = "")
parser.add_argument('-G', "--game", help = "Game to apply changes", type = str, required = False, default = 0)

args = parser.parse_args()

characters = ["Chicken", "Snake", "Dog", "Bat"]

def run():
    try:
        for i in range(100):
            os.system("curl -X POST -H 'content-type: application/json' -H 'Authorization: bearer " + args.auth + "' https://the-pit-cloud-3fiy6wgliq-nw.a.run.app/api/scheduled-game-participants -d '{ \"data\": { \"nft_id\": \"0x03dE5D4eA3c9a899F09C56dDD3b1FCAb68af9FED/" + str(i) + "\", \"user_address\": \"0xb960d6b39023cec0e9c22bcf43e46705b5ddb572\", \"name\": \"\", \"image_address\": \"\", \"scheduled_game\": " + str(args.game) +" } }'")
    except KeyboardInterrupt as e:
        return

if __name__ == "__main__":
    run()
