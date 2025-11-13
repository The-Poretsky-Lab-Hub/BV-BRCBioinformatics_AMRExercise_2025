#!/usr/bin/env Rscript

# Title: Calculating AMR richness and diversity from MRM output (converted to tsv)
# Name: Jamal Sheriff
# Date: 22 May 2025 

# DESCRIPTION: R Script will return the number of AMR genes, shannon index, and inverse simpson index.
#
# This function requires two arguments. args[1] = input file, args[2] = output file name with csv extension 

# Load packages 
library(dplyr)
library(tibble)
library(vegan)

# set command line arguments ----
args <- commandArgs(trailingOnly = TRUE)

#stop the script if no command line argument
if(length(args)==0){
  print("Please select input file.")
  stop("Requires command line argument.")
}

calc_AMR_Richness_Diversity <- function(file) {
  df = read.delim(file, header = TRUE)
  
  data.frame() %>% # create DF with a row for each sample 
    matrix(ncol = 0, nrow = 1) -> richness_df
  
  row.names(richness_df) = strsplit(file, "\\_MRM.tsv")[[1]][1] # set rownames after beginning of filename 
  
  for(rows in df) { # for rows in df, AMR richness = number of all rows 
    AMR_Richness = nrow(df)
  } 
  
  AMR_Shannon = diversity(df[,9], index = 'shannon')
  
  AMR_Inverse_Simpson <- diversity(df[,9], index = 'invsimpson')
 
  richness_df <- as.data.frame(cbind(richness_df, AMR_Richness, AMR_Shannon, AMR_Inverse_Simpson)) # add richness values to output DF
  richness_df <- tibble::rownames_to_column(richness_df, "Sample")
  return(richness_df)
} 

# Run Function

AMR_Diversity <- calc_AMR_Richness_Diversity(args[1])

#Save output

AMR_Diversity$Sample <- as.character(AMR_Diversity$Sample)
AMR_Diversity$AMR_Richness <- as.numeric(AMR_Diversity$AMR_Richness)
AMR_Diversity$AMR_Shannon <- as.numeric(AMR_Diversity$AMR_Shannon)
AMR_Diversity$AMR_Inverse_Simpson <- as.numeric(AMR_Diversity$AMR_Inverse_Simpson)

print(AMR_Diversity)

write.csv(AMR_Diversity, args[2], row.names = FALSE) 


