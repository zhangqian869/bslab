#!/bin/bash



#1 Search 'ACTC1[gene]' in the ClinVar database
#2 Choose 'Likely Pathogenic' and 'Pathogenic' filters
#3 Download the text file


# extact the disease associated mutations 


for i in `cat geneName`
do
grep "p\." ${i}_clinvar_result.txt | awk '{ print $2 }' | sed -e 's/(p.//g' | sed -e 's/)//'g | sort -k 1 -g | uniq > $i
done
