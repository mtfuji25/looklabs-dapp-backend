import os
from datetime import datetime, timedelta

os.system("curl -X PUT -H 'content-type: application/json' https://the-pit-cloud-3fiy6wgliq-nw.a.run.app/api/scheduled-games/30 -d '{ \"data\": {\"game_date\": \"" + f"{ datetime.utcnow() + timedelta(seconds=35) }" + "\" }}'")