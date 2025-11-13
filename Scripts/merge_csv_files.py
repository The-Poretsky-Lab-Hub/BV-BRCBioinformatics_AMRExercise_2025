#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed May 14 12:54:38 2025

@author: jamalsheriff

Title: Merge csv output files from calc_richness_bracken R Script.
This script is used to merge all files by a common column. 

"""

import os
import sys
import glob
import pandas as pd



def merge_csv_files(folder_path, output_filename="richness_merged.csv"):
    """
    Merges all CSV files in a folder by column and saves the result to a new CSV file.

    Args:
        folder_path (str): The path to the folder containing the CSV files.
        output_filename (str, optional): The name of the output CSV file. Defaults to "richness_merged.csv".
    """
    
    all_files = glob.glob(os.path.join(folder_path, "*.csv"))
    print("CSV Files being merged:", all_files)

    if not all_files:
        print("No CSV files found in the specified folder.")
        return

    all_df = [pd.read_csv(f) for f in all_files]

    merged_df = pd.concat(all_df, axis=0) # axis =1 -> concatentates by rows

    merged_df.to_csv(os.path.join(folder_path, output_filename), index=False)
    print(f"Merged CSV file saved as {output_filename} in {folder_path}")

if __name__ == "__main__":
    folder_path = sys.argv[1]
    if len(folder_path) > 0:
        merge_csv_files(folder_path) 
    else:
        print("No folder path is provided")