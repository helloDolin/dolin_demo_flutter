
input_file_path = 'input.txt'  # 输入文件路径
output_file_path = 'output.txt'  # 输出文件路径


def get_dart_snippet():
    with open(input_file_path, 'r') as input_file, open(output_file_path, 'w') as output_file:
        # 逐行读取输入文件内容
        for line in input_file:
            # 添加双引号并写入输出文件
            modified_line = f'"{line.rstrip()}"\n'  # 添加双引号到行的开头和末尾
            output_file.write(modified_line)

    print(f'处理完成，结果已保存到 {output_file_path} 文件中。')


def main():
    get_dart_snippet()


if __name__ == '__main__':
    main()
