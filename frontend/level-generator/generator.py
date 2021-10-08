import json
from PIL import Image

with open("config.json") as file:
    configs = json.load(file)

level_soil = {
    "width": configs["soil"]["width"],
    "height": configs["soil"]["height"],
    "mappings": [],
    "data": [],
}

level_wall = {
    "width": configs["wall"]["width"],
    "height": configs["wall"]["height"],
    "mappings": [],
    "data": [],
}

level_collider = {
    "width": configs["collider"]["width"],
    "height": configs["collider"]["height"],
    "mappings": [],
    "data": [],
}


def create_mappings():
    for i in configs["soil"]["mappings"]:
        level_soil["mappings"].append(i["name"])

    for j in configs["wall"]["mappings"]:
        level_wall["mappings"].append(j["name"])

    for k in configs["collider"]["mappings"]:
        level_collider["mappings"].append(k["name"])

def run():
    create_mappings()

    soil_img = Image.open("soil.png")
    wall_img = Image.open("wall.png")
    collider_img = Image.open("collider.png")

    soil_pix = soil_img.load()
    wall_pix = wall_img.load()
    collider_pix = collider_img.load()

    for i in range(150):
        rows = []
        for j in range(150):
            color = soil_pix[j, i]
            index = 0
            for maping in configs["soil"]["mappings"]:
                if color[0] == maping["color"][0] and color[1] == maping["color"][1] and color[2] == maping["color"][2] and color[3] == maping["color"][3]:
                    index = maping["index"]
            
            rows.append(index)
        level_soil["data"].append(rows)
    
    for i in range(150):
        rows = []
        for j in range(150):
            color = wall_pix[j, i]
            index = 0
            for maping in configs["wall"]["mappings"]:
                if color[0] == maping["color"][0] and color[1] == maping["color"][1] and color[2] == maping["color"][2] and color[3] == maping["color"][3]:
                    index = maping["index"]
            rows.append(index)
        level_wall["data"].append(rows)

    for i in range(150):
        rows = []
        for j in range(150):
            color = collider_pix[j, i]
            index = 0
            for k in configs["collider"]["mappings"]:
                if color[0] == k["color"][0] and color[1] == k["color"][1] and color[2] == k["color"][2] and color[3] == k["color"][3]:
                    index = k["index"]
            rows.append(index)
        level_collider["data"].append(rows)


    with open("level_soil.json", "w") as file:
        json.dump(level_soil, file)

    with open("level_wall.json", "w") as file:
        json.dump(level_wall, file)

    with open("level_collider.json", "w") as file:
        json.dump(level_collider, file)

if __name__ == "__main__":
    run()