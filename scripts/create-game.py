import os
import argparse
from datetime import datetime, timedelta

parser = argparse.ArgumentParser(description = "Create game parameters")
parser.add_argument('-A', "--auth", help = "Current bearer token", type = str, required = False, default = "")
parser.add_argument('-T', "--time", help = "Time after utcnow to start game in seconds", type = int, required = False, default = 30)
parser.add_argument('-G', "--game", help = "Game to apply changes", type = str, required = False, default = -1)

args = parser.parse_args()

def run():
    try:
        if (args.game == -1):
            os.system("curl -X POST -H 'content-type: application/json' -H 'Authorization: bearer " + args.auth + "' https://the-pit-cloud-3fiy6wgliq-nw.a.run.app/api/scheduled-games/" + " -d '{ \"data\": {\"game_date\": \"" + f"{ datetime.utcnow() + timedelta(seconds = int(args.time)) }" + "\" }}'")
        else:
            os.system("curl -X PUT -H 'content-type: application/json' -H 'Authorization: bearer " + args.auth + "' https://the-pit-cloud-3fiy6wgliq-nw.a.run.app/api/scheduled-games/" + args.game + " -d '{ \"data\": {\"game_date\": \"" + f"{ datetime.utcnow() + timedelta(seconds = int(args.time)) }" + "\" }}'")
    except KeyboardInterrupt as e:
        return

if __name__ == "__main__":
    run()
