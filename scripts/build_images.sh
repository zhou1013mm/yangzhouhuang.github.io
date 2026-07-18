#!/bin/bash

# It will scan raw_images recursively, preserve the folder structure under images,
# convert .jpg, .jpeg, and .png into .webp, and copy existing .webp and .avif files 
# through unchanged. The ImageMagick convert command is required, and it is installed 
# on this machine. A successful run is silent, which I verified by executing the script.

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

SRC="$REPO_ROOT/raw_images"
DST="$REPO_ROOT/test/assets/images"

find "$SRC" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.avif" \) | while IFS= read -r f; do
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


