import os

# 指定目录路径
directory_path = '/Users/bd/Desktop/flutter_aiera/images/icon'

# 输出文件路径
output_file_path = 'output.txt'


def snake_to_camel(snake_str):
    # components = snake_str.split('_')
    # # 将每个单词的首字母大写，然后连接起来
    # camel_str = ''.join(x.capitalize() or '_' for x in components)
    # # 如果原始字符串以下划线开头，保留第一个下划线
    # if snake_str.startswith('_'):
    #     camel_str = '_' + camel_str
    # return camel_str

    components = snake_str.split('_')
    # 将第一个单词保持小写，其他单词的首字母大写，然后连接起来
    camel_str = components[0] + ''.join(x.capitalize() for x in components[1:])
    return camel_str


def get_all_files_in_directory(directory):
    file_paths = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            file_path = os.path.join(root, file)
            file_paths.append(file_path)
    return file_paths


def main():
    # 获取目录下所有文件的路径
    files = get_all_files_in_directory(directory_path)

    # 打印文件路径
    data = []
    for file in files:
        asset_path = ''
        index = file.find("/images/")
        if index != -1:
            # 提取 "/images/" 后的子字符串
            asset_path = file[index + 1:]

        # 获取文件名
        file_name = os.path.basename(file)

        # 分割文件名和扩展名
        base_name, extension = os.path.splitext(file_name)

        # 如果需要去掉扩展名，只保留 kpi_month_bg
        result = base_name
        asset_name = snake_to_camel(result)

        res = f'static const {asset_name} = \'{asset_path}\';\n'
        data.append(res)

        print(data)

        with open(output_file_path, 'w') as output_file:
            # 逐行读取输入文件内容
            for line in data:
                output_file.write(line)


if __name__ == '__main__':
    main()
