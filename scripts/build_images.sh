#!/bin/bash
set -e

SRC=raw_images
DST=/home/huangyangzhou/github/yangzhouhuang.github.io/test/assets/images 

find "$SRC" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.avif" \) | while read f; do
  rel="${f#$SRC/}"
  outdir="$DST/$(dirname "$rel")"
  mkdir -p "$outdir"
  name="${rel%.*}"
  ext="${f##*.}"

  if [[ "$ext" == "webp" || "$ext" == "avif" ]]; then
    cp "$f" "$DST/$rel"
  else
    convert "$f" -auto-orient -resize 800x800\> -strip "$DST/$name.webp"
  fi
done


