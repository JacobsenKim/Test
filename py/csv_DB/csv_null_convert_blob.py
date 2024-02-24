#!/usr/bin/env python
#chmod +x csv_null_convert_blob.py
#python3 csv_null_convert_blob.py
#
#
#
#
import os
import csv
import re

# Function to process a single CSV file
def process_csv(input_file, output_file):
    with open(input_file, 'r', newline='', encoding='utf-8') as infile, open(output_file, 'w', newline='', encoding='utf-8') as outfile:
        writer = csv.writer(outfile)

        for line in infile:
            # Remove NUL characters
            cleaned_line = line.replace('\x00', '')
            # Replace non-UTF-8 characters
            cleaned_line = cleaned_line.encode('utf-8', 'ignore').decode('utf-8')
            # Split the line into fields using CSV reader
            reader = csv.reader([cleaned_line])
            row = next(reader)  # Get the first (and only) row
            # Replace empty fields with 'NULL'
            new_row = ['NULL' if field.strip() == '' else field.strip() for field in row]
            # Write the cleaned row to the output file
            writer.writerow(new_row)

# Directory containing the CSV files
input_directory = '/home/kim/Hentet/HA_mariaDB/input'
output_directory = '/home/kim/Hentet/HA_mariaDB/output'

# Iterate through each file in the input directory
for filename in os.listdir(input_directory):
    if filename.endswith('.csv'):
        input_file = os.path.join(input_directory, filename)
        output_file = os.path.join(output_directory, filename)
        process_csv(input_file, output_file)

print("Conversion complete.")









