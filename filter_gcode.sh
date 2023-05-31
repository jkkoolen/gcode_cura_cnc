#!/bin/zsh

# Check if the 'star.gcode' file exists
if [ -f "$1" ]; then
    # Read the contents of the 'star.gcode' file, remove comments, extrusion values, and unwanted commands
    cat "$1" | sed '/^;/d' | sed "s/ E[^ ]*//" | sed '/^G92.*/d' | sed '/^G11.*/d' | sed '/^G10.*/d' | sed 's/Z/Z-/' | sed '/^M107.*/d' | sed '/^M82.*/d' > result.gcode
    cat result.gcode | pbcopy

    echo "Filtered G-code has been copied to the clipboard."
else
    echo "Usage: ./filter_gcode.sh <filename>"
    echo "Please provide a valid 'gcode' file as an argument."
fi

