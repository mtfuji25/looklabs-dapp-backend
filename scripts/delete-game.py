import os
import argparse
from datetime import datetime, timedelta

parser = argparse.ArgumentParser(description = "Create game parameters")
parser.add_argument('-I', "--init", help = "First game range id to delete", type = int, required = True)
parser.add_argument('-F', "--final", help = "Last game range id to delete", type = int, required = True)

args = parser.parse_args()

def run():
    for i in range(args.init, args.final + 1, 1):
        os.system("curl -X DELETE -H 'content-type: application/json' http://localhost:1337/api/scheduled-games/" + str(i))

if __name__ == "__main__":
    run()
