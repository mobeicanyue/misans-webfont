#!/bin/bash

pwd

# 下载字体压缩包
wget --tries=10 --wait=5 https://hyperos.mi.com/font-download/MiSans_Global_ALL.zip || exit 1
printf "\n\n\n\n"

echo "解压字体文件"
unzip MiSans_Global_ALL.zip
printf "\n\n\n\n"

echo "删除无用文件"
rm -rf '__MACOSX'
rm MiSans_Global_ALL.zip
printf "\n\n\n\n"

ls -l
printf "\n\n\n\n"

echo "重命名文件夹"
mv 'MiSans Global _ALL' 'tmp'
cd 'tmp' || exit

ls -l
printf "\n\n\n\n"

echo "将所有 .zip 文件解压到对应文件夹"
unzip -o '*.zip'
printf "\n\n\n\n"

echo "删除所有 __MACOSX 文件夹"
find . -type d -name "__MACOSX" -exec rm -rf {} +
printf "\n\n\n\n"

echo "查找当前目录及其子目录中所有文件，并删除所有不是 .otf 后缀的文件"
find . -type f ! -name '*.otf' -exec rm -f {} +
printf "\n\n\n\n"

echo "查找当前目录及其子目录中所有空目录，并删除它们"
find . -type d -empty -exec rmdir {} +
printf "\n\n\n\n"

mv 'MiSans L3/MiSans L3.otf' 'MiSans L3/MiSans-L3.otf'
mv 'MiSana Arabic' 'MiSans Arabic'
