#!/bin/bash

pwd

echo "开始分割字体文件..."

mkdir -p ./fonts

# 遍历每个文件夹
for folder in ./tmp/*; do
    # 检查当前路径是否是一个文件夹
    if [ -d "$folder" ]; then
        # 获取文件夹名称
        folder_name=$(basename "$folder")
        echo "正在处理目录：$folder_name:"
        echo "$folder_name 的目录结构:"
        tree "$folder"
        # 遍历文件夹中的 .otf 文件
        for file in "$folder"/*.otf; do
            echo "正在处理文件：$file:"
            # 检查当前文件是否存在
            if [ -e "$file" ]; then
                # 获取文件名（不包含扩展名）
                font_name=$(basename "$file" .otf | tr '[:upper:]' '[:lower:]')
                # 使用 cn-font-split 拆分字体文件
                cn-font-split -i="$file" -o="./fonts/$folder_name/$font_name/" --renameOutputFont='[index][ext]' --reporter='false' --testHTML='false' || exit 1

                touch "./fonts/$folder_name/style.css"
                # 生成 CSS 导入语句
                echo "@import url('./$folder_name/$font_name/result.css');" >>"./fonts/$folder_name/style.css"
            fi
        done
    fi
done
