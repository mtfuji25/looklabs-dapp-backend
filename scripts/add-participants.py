
import os

characters = ["Chicken", "Snake", "Dog", "Bat"]

for i in range(100):
    os.system("curl -X POST -H 'Accept: */*' -H 'content-type: application/json' https://the-pit-cloud-3fiy6wgliq-nw.a.run.app/api/scheduled-game-participants -d '{ \"data\": { \"nft_id\": \"e3afc60c-a846-4b4e-bf19-6656d6fb8e8" + str(i) + "/" + str(i) + "\", \"user_address\": \"0xb960d6b39023cec0e9c22bcf43e46705b5ddb572\", \"name\": \"\", \"image_address\": \"\", \"scheduled_game\": 10 } }'")
