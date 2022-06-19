#!/bin/bash

# extact the ptm sites information from the downloaded PSP dataset


# !!! regardless of number of recordings reporting the phosphorylation site !!!
# !!! only human  !!!


awk '{ if ( $2 == "ACTC1" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > actc1
awk '{ if ( $2 == "ACTN2" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > actn2
awk '{ if ( $2 == "MYBPC3" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > mybpc3
awk '{ if ( $2 == "MYH6" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > myh6
awk '{ if ( $2 == "MYH7" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > myh7
awk '{ if ( $2 == "MYL3" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > myl3
awk '{ if ( $2 == "MRLC2V" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > myl2
awk '{ if ( $2 == "MYL7" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > myl7
awk '{ if ( $2 == "TNNC1" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > tnnc1
awk '{ if ( $2 == "TNNI3" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > tnni3
awk '{ if ( $2 == "TNNT2" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > tnnt2
awk '{ if ( $2 == "TPM1" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > tpm1
awk '{ if ( $2 == "TPM3" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > tpm3
awk '{ if ( $2 == "Titin" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | uniq > ttn
