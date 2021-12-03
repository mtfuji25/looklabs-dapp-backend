import json
import imageio
import numpy as np
from PIL import Image


collider_json = {
    "width": 116,
    "height": 116,
    "data": [],
}

basemap_json = {
    "width": 116,
    "height": 64,
    "data": [],
}

overlays_json = {
    "width": 116,
    "height": 64,
    "data": [],
}

def compare_two_units(unit1, unit2) -> bool:

    disparity = 0.0
    percents_r = []
    percents_g = []
    percents_b = []

    for i in range(16):
        for j in range(16):
            pixel1 = unit1[i][j]
            pixel2 = unit2[i][j]

            if pixel1[0] == pixel2[0] and pixel1[1] == pixel2[1] and pixel1[2] == pixel2[2]:
                continue
            else:
                disparity += 1
                percent_r = abs(pixel1[0] - pixel2[0]) / 255
                percent_g = abs(pixel1[1] - pixel2[1]) / 255
                percent_b = abs(pixel1[2] - pixel2[2]) / 255

                percents_r.append(percent_r)
                percents_g.append(percent_g)
                percents_b.append(percent_b)

    total_r = 0.0
    total_g = 0.0
    total_b = 0.0

    for i in percents_r:
        total_r += i

    for j in percents_g:
        total_g += j

    for k in percents_g:
        total_b += k

    return {
        "error": disparity / 256,
        "percent": {
            "r": total_r / len(percents_r) if len(percents_r) != 0 else 0,
            "g": total_g / len(percents_g) if len(percents_g) != 0 else 0,
            "b": total_b / len(percents_b) if len(percents_b) != 0 else 0,
        }
    }


def extract_units(pix):
    imgs = []

    offI = 0
    offJ = 0
    for a in range(116):
        for b in range(116):
            row = []
            for i in range(16):
                col = []
                for j in range(16):
                    color = pix[j + offI, i + offJ]
                    col.append([color[0], color[1], color[2], color[3]])
                row.append(col)
            imgs.append(row)
            offJ += 16
        offI += 16
        offJ = 0

    return imgs


def generate_data(pix, base_sheet, json_data):
    offI = 0
    offJ = 0
    for a in range(116):
        data_row = []
        for b in range(116):
            row = []
            for i in range(16):
                col = []
                for j in range(16):
                    color = pix[j + offI, i + offJ]
                    col.append([color[0], color[1], color[2], color[3]])
                row.append(col)
            for i, img in enumerate(base_sheet):
                res = compare_two_units(row, img)
                if res["error"] < 0.0234375 and res["percent"]["r"] < 0.1 and res["percent"]["g"] < 0.1 and res["percent"]["b"] < 0.1:
                    data_row.append(i)
            offJ += 16
        offI += 16
        offJ = 0
        json_data["data"].append(data_row)


def run():

    # Carrega as imagens
    # base_img = Image.open("assets/basemap.png")
    # overlays_img = Image.open("assets/overlays.png")
    collider_img = Image.open("assets/collider.png")

    # Extrai o array de pixels
    # base_pix = base_img.load()
    # overlays_pix = overlays_img.load()
    collider_pix = collider_img.load()

    # base_imgs = extract_units(base_pix)
    # overlay_imgs = extract_units(overlays_pix)
    collider_imgs = extract_units(collider_pix)

    # Compare for basemap
    # base_sheet = []
    # overlay_sheet = []
    collider_sheet = []

    # for i, img in enumerate(base_imgs):
    #     equals = []
    #     for j, other in enumerate(base_imgs):
    #         if i == j:
    #             continue
    #         else:
    #             res = compare_two_units(img, other)
    #             if res["error"] < 0.0234375 and res["percent"]["r"] < 0.1 and res["percent"]["g"] < 0.1 and res["percent"]["b"] < 0.1:
    #                 equals.append(other)
    #     if len(equals) == 0:
    #         base_sheet.append(img)
    #     else:
    #         base_sheet.append(img)
    #         for other in equals:
    #             base_imgs.remove(other)

    # for i, img in enumerate(overlay_imgs):
    #     equals = []
    #     for j, other in enumerate(overlay_imgs):
    #         if i == j:
    #             continue
    #         else:
    #             res = compare_two_units(img, other)
    #             if res["error"] < 0.0234375 and res["percent"]["r"] < 0.1 and res["percent"]["g"] < 0.1 and res["percent"]["b"] < 0.1:
    #                 equals.append(other)
    #     if len(equals) == 0:
    #         overlay_sheet.append(img)
    #     else:
    #         overlay_sheet.append(img)
    #         for other in equals:
    #             overlay_imgs.remove(other)

    for i, img in enumerate(collider_imgs):
        equals = []
        for j, other in enumerate(collider_imgs):
            if i == j:
                continue
            else:
                res = compare_two_units(img, other)
                if res["error"] < 0.0234375 and res["percent"]["r"] < 0.1 and res["percent"]["g"] < 0.1 and res["percent"]["b"] < 0.1:
                    equals.append(other)
        if len(equals) == 0:
            collider_sheet.append(img)
        else:
            collider_sheet.append(img)
            for other in equals:
                collider_imgs.remove(other)

    # for i, img in enumerate(base_sheet):
    #     imageio.imwrite("basemap/basemap" + str(i) + ".png", np.array(img, np.uint8))

    # for i, img in enumerate(overlay_sheet):
    #     imageio.imwrite("overlays/overlay" + str(i) + ".png", np.array(img, np.uint8))

    for i, img in enumerate(collider_sheet):
        imageio.imwrite("collider/collider" + str(i) + ".png", np.array(img, np.uint8))

    # generate_data(base_pix, base_sheet, basemap_json)
    # generate_data(overlays_pix, overlay_sheet, overlays_json)
    generate_data(collider_pix, collider_sheet, collider_json)

    # with open("level_map.json", "w") as file:
    #     json.dump(basemap_json, file)

    # with open("level_overlays.json", "w") as file:
    #     json.dump(overlays_json, file)

    for i in collider_json["data"]:
        for j in range(len(i)):
            i[j] = 0 if i[j] == 1 else 1

    with open("level_collider.json", "w") as file:
        json.dump(collider_json, file)

if __name__ == "__main__":
    run()