#!/bin/bash

# usage : bash scripts/batch_rename.sh path/to/your/images
# if you omit the path arg, it will rename images in the current directory.

set -e

target_dir="${1:-.}"

if [ ! -d "$target_dir" ]; then
    echo "Usage: $0 [directory]"
    echo "Error: directory not found: $target_dir" >&2
    exit 1
fi

i=1
for pic in "$target_dir"/*; do
    # 跳过非文件（目录、链接等）
    [ -f "$pic" ] || continue

    # 跳过已正确命名的文件（避免重复处理）
    [ "$pic" = "$target_dir/${i}.webp" ] && { ((i++)); continue; }

    # 如果目标名已存在，跳过防止覆盖
    if [ -e "$target_dir/${i}.webp" ]; then
        echo "跳过：${i}.webp 已存在"
        ((i++))
        continue
    fi

    mv "$pic" "$target_dir/${i}.webp"
    echo "重命名: $pic -> $target_dir/${i}.webp"
    ((i++))
done
