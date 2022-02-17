import os
import argparse

parser = argparse.ArgumentParser(description = "Create game parameters")
parser.add_argument('-I', "--init", help = "First game range id to delete", type = int, required = True)
parser.add_argument('-F', "--final", help = "Last game range id to delete", type = int, required = True)
parser.add_argument('-P', "--participants", help = "Number of participants per game", type = int, required = True)

args = parser.parse_args()

def run():
    for i in range(args.init, args.final + 1, 1):
        for j in range(1, args.participants + 1, 1):
            os.system("curl -X POST -H 'content-type: application/json' http://localhost:1337/api/scheduled-game-participants -d '{ \"data\": { \"nft_id\": \"0x03dE5D4eA3c9a899F09C56dDD3b1FCAb68af9FED/" + str(j) + "\", \"user_address\": \"0xb960d6b39023cec0e9c22bcf43e46705b5ddb572\", \"name\": \"\", \"image_address\": \"\", \"scheduled_game\": " + str(i) +" } }'")

if __name__ == "__main__":
    run()
