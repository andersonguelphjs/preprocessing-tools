#!/bin/bash
# chmod +x create_sprite_sheet.sh.
# chmod +x /path/to/your/script/create_sprite_sheet.sh
# ./create_sprite_sheet.sh.
# ./create_sprite_sheet.sh --tile 4x --background "#FFFFFF" --output "custom_sprite_sheet.png" --input "*.jpg".
# Default values
TILE="3x"
BACKGROUND="none"
OUTPUT_FILE="$(date +'%Y%m%d_%H%M%S')_sprite_sheet.png"
INPUT_FILES="*.png"

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -t|--tile) TILE="$2"; shift ;;
        -b|--background) BACKGROUND="$2"; shift ;;
        -o|--output) OUTPUT_FILE="$2"; shift ;;
        -i|--input) INPUT_FILES="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

# Create sprite sheet
montage $INPUT_FILES -geometry +0+0 -tile $TILE -background $BACKGROUND $OUTPUT_FILE
