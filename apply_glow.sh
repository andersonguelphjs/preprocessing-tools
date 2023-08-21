#!/bin/bash
# applies glow to folder of images
# add_glow.sh.
# chmod +x add_glow.sh.
# ./add_glow.sh.
# ./add_glow.sh --radius 15 --color "red" --type jpg --output "red_glow".
# Default values
GLOW_RADIUS=10
GLOW_COLOR="yellow"
FILE_TYPE="png"
OUTPUT_DIR="glowing"

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -r|--radius) GLOW_RADIUS="$2"; shift ;;
        -c|--color) GLOW_COLOR="$2"; shift ;;
        -t|--type) FILE_TYPE="$2"; shift ;;
        -o|--output) OUTPUT_DIR="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Apply glow effect to images
for file in *.$FILE_TYPE; do
    convert "$file" \( +clone -channel a -morphology Dilate:1 $GLOW_RADIUS -fill $GLOW_COLOR -colorize 100% \) +swap -composite "$OUTPUT_DIR/$file"
done
