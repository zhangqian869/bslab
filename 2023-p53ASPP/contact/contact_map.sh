#!/bin/bash
  

cat>contact_map.in<<EOD

parm ../../struc.pdb
trajin ../../newall.xtc

nativecontacts :1-267@BB :268-434@BB distance 7 writecontacts c0_nativecontacts resout c0_contact-pair out c0_contact-number resoffset 5 contactpdb c0_nativePDB byresidue map mapout c0_map series savenonnative nncontactpdb nonNativePDB

run
EOD

cpptraj -i contact_map.in




awk '{printf "%3s       %3s       %3s\n", $1,$2,$4}' c0_contact-pair> 1.dat

sort -k2 -n 1.dat > res-nn.dat

rm -rf times.dat
echo | awk '{
i=0
n=0
while ( ( getline < "res-nn.dat" ) > 0 ) {
i++
if ( i > 1 ) {
        totalContact[$2] += $3
}
}



for(k=268;k<=434;k++){
       printf "%5s      %5s\n" ,k,totalContact[k] >> "timesBB.dat"
}
}'
