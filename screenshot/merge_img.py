import os

from PIL import Image  # pip3 install pillow


def merge_images(image_files):
    image_count = len(image_files)
    if image_count == 0:
        return

    # 原始尺寸
    original_width = 0

    # 合成后图片尺寸
    new_img_width = 0
    new_img_height = 0

    for i, f in enumerate(image_files):
        img = Image.open(f)
        new_img_width += img.size[0]
        original_width = max(original_width, img.size[0])
        new_img_height = max(new_img_height, img.size[1])
    new_img_width * 2
    print(new_img_width)

    new_img = Image.new('RGB', (new_img_width, new_img_height), 'white')

    for i, f in enumerate(image_files):
        img = Image.open(f)
        new_img.paste(img, (i * original_width, 0))
    new_img.save('./res.png')


if __name__ == '__main__':
    folder_path = "./english"

    file_names = os.listdir(folder_path)
    image_files = []
    for item in file_names:
        if item.endswith('.png'):
            image_files.append(folder_path + '/' + item)

    merge_images(image_files)
