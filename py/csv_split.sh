#!/bin/bash
#
# To spilt large .csv files to smaler ones.
#
# chmod +x csv_split.sh
#
## Run like: 
# ./csv_split.sh youre_csv_file_to_split.csv 
#
input_file="$1"
input_file_name="${input_file##*/}"
split_prefix="${input_file_name%.*}_split_"
split_directory="$HOME/Hentet/HA_mariaDB/output/split_${input_file_name%.*}/"

# Check if the split directory exists, create it if it doesn't
if [ ! -d "$split_directory" ]; then
    mkdir -p "$split_directory"
fi

# Split the input file into smaller files within the split folder
split -a 3 -d -l 10000 "$input_file" "${split_directory}/${split_prefix}"

# Rename the split files with the desired format
counter=0
for file in "${split_directory}/${split_prefix}"*; do
    mv "$file" "${split_directory}/$(printf '%02d' "$counter")_${input_file_name%.*}_split.csv"
    ((counter++))
done

echo "############################################"
echo "All good, it is split. Look at $split_directory for youre split csv files"
echo "############################################"
