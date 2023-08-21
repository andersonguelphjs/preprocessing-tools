#!/bin/bash
#need ImageMagick
# will resize a folder of images to squares, which can then be put in sprite sheet
#chmod +x resize_images.sh
# Default values
#./resize_images.sh (defaults to 64X64 and type .png)
#./resize_images.sh --width 128 --height 128 --type jpg.

WIDTH=64
HEIGHT=64
FILE_TYPE="png"

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -w|--width) WIDTH="$2"; shift ;;
        -h|--height) HEIGHT="$2"; shift ;;
        -t|--type) FILE_TYPE="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Create directories
mkdir -p resized

# Resize images
for file in *.$FILE_TYPE; do
    convert "$file" -resize "${WIDTH}x${HEIGHT}" "resized/$file"
done

cd resized
mkdir -p square

# Add transparent padding
for file in *.$FILE_TYPE; do
    convert "$file" -background none -gravity center -extent ${WIDTH}x${HEIGHT} "square/$file"
done
