import os
import argparse
from datetime import datetime, timedelta

parser = argparse.ArgumentParser(description = "Create game parameters")
parser.add_argument('-N', "--number", help = "First game range id to delete", type = int, required = True)
parser.add_argument('-I', "--interval", help = "Interval between games in minutes", type = int, required = True)

args = parser.parse_args()

def run():
    for i in range(args.number):
        os.system("curl -X POST -H 'content-type: application/json' http://localhost:1337/api/scheduled-games/" + " -d '{ \"data\": {\"game_date\": \"" + f"{ datetime.utcnow() + timedelta(seconds = int(args.interval) * 60 * i) }" + "\" }}'")

if __name__ == "__main__":
    run()
