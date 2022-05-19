#!/bin/bash

# extact the ptm sites information from the downloaded PSP dataset


# !!! regardless of number of recordings reporting the phosphorylation site !!!
# !!! only human !!!

gene=$1  #gene name
output=$2

grep -i $gene Phosphorylation_site_dataset | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > $output
