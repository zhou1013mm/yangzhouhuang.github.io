#!/bin/bash

i=1
for pic in ./*; do
    # 跳过非文件（目录、链接等）
    [ -f "$pic" ] || continue
    
    # 跳过脚本自身（如果脚本也在当前目录）
    [ "$pic" = "./batch_rename.sh" ] && continue
    
    # 跳过已正确命名的文件（避免重复处理）
    [ "$pic" = "./${i}.webp" ] && { ((i++)); continue; }
    
    # 如果目标名已存在，跳过防止覆盖
    if [ -e "${i}.webp" ]; then
        echo "跳过：${i}.webp 已存在"
        ((i++))
        continue
    fi
    
    mv "$pic" "${i}.webp"
    echo "重命名: $pic -> ${i}.webp"
    ((i++))
done
