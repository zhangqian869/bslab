#!/bin/bash



#1 Search 'ACTC1[gene]' in the ClinVar database
#2 Choose 'Likely Pathogenic' and 'Pathogenic' filters
#3 Download the text file


# extact the disease associated mutations 

input=$1  # e.g. actc1_clinvar_result.txt
output=$2  # actc1

grep "p\." $input | awk -F "p." '{ print $2 }' | awk -F ")" '{ print $1 }' > $output
