#!/bin/bash
# applies glow to folder of images
# add_glow.sh.
# chmod +x add_glow.sh.
# ./Users/markanderson/dev/react-native/preprocessing-tools/apply_glow.sh
# ./add_glow.sh.
# ./add_glow.sh --radius 15 --color "red" --type jpg --output "red_glow".
# Default values
GLOW_COLOR="yellow"
FILE_TYPE="png"
OUTPUT_DIR="glowing"
BLUR_RADIUS="0x8"
LEVEL_PERCENT="0,50%"

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -c|--color) GLOW_COLOR="$2"; shift ;;
        -t|--type) FILE_TYPE="$2"; shift ;;
        -o|--output) OUTPUT_DIR="$2"; shift ;;
        -b|--blur) BLUR_RADIUS="$2"; shift ;;
        -l|--level) LEVEL_PERCENT="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Apply glow effect to images
for file in *.$FILE_TYPE; do
    convert "$file" -background none -alpha background -channel A -blur $BLUR_RADIUS -level $LEVEL_PERCENT +channel -fill $GLOW_COLOR -colorize 100% "$OUTPUT_DIR/$file"
done