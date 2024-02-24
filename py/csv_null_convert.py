#!/usr/bin/env python


import os
import csv

# Function to process a single CSV file
def process_csv(input_file, output_file):
    with open(input_file, 'r', newline='') as infile, open(output_file, 'w', newline='') as outfile:
        reader = csv.reader(infile)
        writer = csv.writer(outfile)

        for row in reader:
            new_row = ['NULL' if field == '' else field for field in row]
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
