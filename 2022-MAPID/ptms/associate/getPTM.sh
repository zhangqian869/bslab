#!/bin/bash

# extact the ptm sites information from the downloaded PSP dataset


# !!! regardless of number of recordings reporting the phosphorylation site !!!
# !!! only human  !!!


awk '{ if ( $2 == "ANK2" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > ank2
awk '{ if ( $2 == "CRYAB" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > cryab
awk '{ if ( $2 == "CRIP3" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > crip3
awk '{ if ( $2 == "CAPZA2" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > capza2
awk '{ if ( $2 == "abLIM" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > ablim1
awk '{ if ( $2 == "SPTB1" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > sptb
awk '{ if ( $2 == "CTNNA1" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > ctnna1
awk '{ if ( $2 == "desmin" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > des
awk '{ if ( $2 == "FHL2" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > fhl2
awk '{ if ( $2 == "FLNC" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > flnc
awk '{ if ( $2 == "myomesin" && $3 == "1" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > myom1
awk '{ if ( $2 == "MYOZ2" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > myoz2
awk '{ if ( $2 == "NEBL" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > nebl
awk '{ if ( $2 == "OBSCN" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > obscn
awk '{ if ( $2 == "SYNPO2" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > synpo2
awk '{ if ( $2 == "TGM2" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > tgm2
awk '{ if ( $2 == "TMOD1" ) print }' Phosphorylation_site_dataset  | grep human | grep "\-p" | awk -F "-p" '{ print $1 }'| awk '{ print $NF }' | sort -k 1 -g | uniq > tmod1
