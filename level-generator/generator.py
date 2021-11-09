import json
from PIL import Image

with open("config.json") as file:
    configs = json.load(file)

level_map = {
    "width": configs["width"],
    "height": configs["height"],
    "data": [],
}

level_collider = {
    "width": configs["width"],
    "height": configs["height"],
    "data": [],
}

def run():
    soil_img = Image.open("map.png")
    collider_img = Image.open("collider.png")

    soil_pix = soil_img.load()
    collider_pix = collider_img.load()

    for i in range(90):
        rows = []
        for j in range(90):
            color = soil_pix[j, i]
            index = 0
            for maping in configs["mappings"]:
                if color[0] == maping["color"][0] and color[1] == maping["color"][1] and color[2] == maping["color"][2] and color[3] == maping["color"][3]:
                    index = maping["index"]
            
            rows.append(index)
        level_map["data"].append(rows)

    collider = configs["collider"]
    for i in range(90):
        rows = []
        for j in range(90):
            color = collider_pix[j, i]
            index = 0
            if color[0] == collider["color"][0] and color[1] == collider["color"][1] and color[2] == collider["color"][2] and color[3] == collider["color"][3]:
                index = collider["index"]
            rows.append(index)
        level_collider["data"].append(rows)


    with open("level_map.json", "w") as file:
        json.dump(level_map, file)

    with open("level_collider.json", "w") as file:
        json.dump(level_collider, file)

if __name__ == "__main__":
    run()