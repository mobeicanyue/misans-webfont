import os
import shutil

print("开始处理字体文件夹...")
os.system('pwd')
os.system('ls -l')


# 重命名当前目录下的文件夹，去掉两边的空格，转换为小写，中间的空格替换为短横线
def rename_directory(root_dir, directory):
    # 构建源目录路径和目标目录路径
    source_path = os.path.join(root_dir, directory)
    destination_path = os.path.join(root_dir, directory.strip().lower().replace(' ', '-'))

    # 重命名目录
    try:
        os.rename(source_path, destination_path)
        print(f"重命名目录 '{source_path}' 到 '{destination_path}'")
        return destination_path
    except Exception as e:
        print(f"重命名目录 '{source_path}' 到 '{destination_path}' 时发生错误：{e}")


# 移动所有的 otf 文件到其上级目录
def move_otf_files(sub_dir_path):
    print(f"移动所有的 otf 文件到子目录 '{sub_dir_path}'...")
    for root, _, files in os.walk(sub_dir_path, topdown=False):
        # print(f"move_otf_files 处理目录 '{root}'...")
        # 遍历所有文件
        for file in files:
            # print(f"处理文件 '{file}'...")
            # 如果文件是 otf 文件，则移动到子目录
            if file.endswith('.otf'):
                source_path = os.path.join(root, file)
                destination_path = os.path.join(sub_dir_path, file)
                try:
                    shutil.move(source_path, destination_path)
                    print(f"移动文件 '{source_path}' 到 '{destination_path}'")
                except Exception as e:
                    print(f"移动文件 '{source_path}' 到 '{destination_path}' 时发生错误：{e}")


# 删除空文件夹
def remove_empty_folders(root_folder):
    # 获取 root_folder 下的所有文件和文件夹
    for root, dirs, _ in os.walk(root_folder, topdown=False):
        # 遍历所有文件夹
        for folder in dirs:
            folder_path = os.path.join(root, folder)
            # 如果文件夹为空，则删除
            if not os.listdir(folder_path):
                print(f"Removing empty folder: {folder_path}")
                os.rmdir(folder_path)


# 设置你的根目录路径
root_dir = 'tmp'

for dir in os.listdir(root_dir):
    print(f"\n处理目录 '{dir}'...\n")
    destination_path = rename_directory(root_dir, dir)
    move_otf_files(destination_path)

# 删除空文件夹
remove_empty_folders(root_dir)

os.system('tree tmp')
