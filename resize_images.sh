#!/bin/bash
#need ImageMagick
# will resize a folder of images to squares, which can then be put in sprite sheet
#chmod +x resize_images.sh
# Default values
#./resize_images.sh (defaults to 64X64 and type .png)
#./resize_images.sh --width 128 --height 128 --type jpg.

WIDTH=128
HEIGHT=128
FILE_TYPE="png"
PADDING=15

# Calculate the dimensions after considering padding
RESIZE_WIDTH=$((WIDTH - 2*PADDING))
RESIZE_HEIGHT=$((HEIGHT - 2*PADDING))

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -w|--width) WIDTH="$2"; shift ;;
        -h|--height) HEIGHT="$2"; shift ;;
        -t|--type) FILE_TYPE="$2"; shift ;;
        -p|--padding) PADDING="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Create directories
mkdir -p resized

# Resize images
for file in *.$FILE_TYPE; do
    convert "$file" -resize "${RESIZE_WIDTH}x${RESIZE_HEIGHT}" "resized/$file"
done

cd resized
mkdir -p square

# Add transparent padding
for file in *.$FILE_TYPE; do
    convert "$file" -background none -gravity center -extent ${WIDTH}x${HEIGHT} "square/$file"
done
