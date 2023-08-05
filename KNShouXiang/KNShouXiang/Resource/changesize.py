from PIL import Image
import os

def resize_image(input_image_path, output_image_path, size):
    with Image.open(input_image_path) as image:
        image = image.resize(size)
        image.save(output_image_path)

# 获取当前目录下的所有文件和文件夹
entries = os.listdir()

# 遍历当前目录下的所有条目
for entry in entries:
    # 检查条目是否为 .png 图片
    if entry.endswith(".png"):
        # 设置新的尺寸
        new_size = (600, 815)
        
        # 调整图片尺寸并覆盖原始图片
        resize_image(entry, entry, new_size)
        
        print(f"Resized {entry} to size {new_size}")
