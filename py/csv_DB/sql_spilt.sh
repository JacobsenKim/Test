#!/bin/bash
#
# To spilt large .sql files to smaler ones.
# Remember to edit the end of the split file with ; to end the file.
# Copy sql_split.sh to youre HOME dir
#
# chmod +x sql_split.sh
#
## Run like: 
# ./sql_spilt.sh your_csv_file_to_split.csv
##############################################
# Change to youre working dir.
#
workdir="$HOME/Hentet/HA_mariaDB/output"
#
##############################################
#
input_file="$workdir/$1"
input_file_name="${input_file##*/}"
split_prefix="${input_file_name%.*}_split_"
split_directory="$workdir/split_${input_file_name%.*}"

# Check if the split directory exists, create it if it doesn't
if [ ! -d "$split_directory" ]; then
    mkdir -p "$split_directory"
fi

echo "Split in progress..."

# Split the input file into smaller files within the split folder
split -a 3 -d -l 500000 "$input_file" "${split_directory}/${split_prefix}"

# Rename the split files with the desired format
counter=0
for file in "${split_directory}/${split_prefix}"*; do
    mv "$file" "${split_directory}/$(printf '%02d' "$counter")_${input_file_name%.*}_split.sql"
    ((counter++))
done

echo "############################################"
echo "Split in progress finish.... Look at $split_directory for youre split csv files"
echo "############################################"
