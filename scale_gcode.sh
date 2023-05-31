#!/bin/zsh

if [[ $# -ne 1 ]]; then
  echo "Usage: ./scale_gcode.sh <file_path>"
  exit 1
fi

file_path=$1
scale_factor=10.0

scaled_file_path="${file_path:r}_scaled.gcode"
rm ${scaled_file_path}

while IFS= read -r line; do
  if [[ $line == G[01]*X* ]] || [[ $line == G[01]*Y* ]] || [[ $line == G[01]*Z* ]]; then
    scaled_line=$(echo "$line" | awk -v scale="$scale_factor" '{
        for (i=1; i<=NF; i++) {
            if ($i ~ /^[XYZ]/) {
                coordinate = substr($i, 2)
                $i = substr($i, 1, 1) (coordinate * scale)
            }
        }
        print
    }')
    echo "$scaled_line" >> "$scaled_file_path"
  else
    echo "$line" >> "$scaled_file_path"
  fi
done < "$file_path"

echo "G-code file scaled by $scale_factor and saved as $scaled_file_path."

