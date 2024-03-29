#!/usr/bin/env python
#
# chmod +x sql_clean.py
#
# python3 sql_clean.py
#


import os
import zipfile

# Function to process a single SQL file
def process_sql(input_file, output_file):
    with open(input_file, 'r', encoding='utf-8') as infile, open(output_file, 'w', encoding='utf-8') as outfile:
        for line in infile:
            # Remove the line containing "BEGIN TRANSACTION;"
            if "BEGIN TRANSACTION;" in line:
                continue
            # Replace double quotes with nothing
            cleaned_line = line.replace('"', '')
            # Replace \' with \'\'
            if 'events.sql' in input_file:
                cleaned_line = cleaned_line.replace("\\'", "\\\\'")
            outfile.write(cleaned_line)

# Directory containing the SQL files
input_directory = '/home/kim/Hentet/HA_mariaDB/input'
output_directory = '/home/kim/Hentet/HA_mariaDB/output'

print("Conversion in progress....")

# Iterate through each file in the input directory
for filename in os.listdir(input_directory):
    if filename.endswith('.sql'):
        input_file = os.path.join(input_directory, filename)
        output_file = os.path.join(output_directory, filename)
        process_sql(input_file, output_file)

        # Create a zip file for the processed SQL file
        zip_filename = os.path.join(output_directory, filename + '.zip')
        with zipfile.ZipFile(zip_filename, 'w', zipfile.ZIP_DEFLATED) as zipf:
            zipf.write(output_file, os.path.basename(output_file))

print("Conversion complete.")



