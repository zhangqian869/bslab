#!/bin/bash


# the first step is to generate the PDBQR files for the RNA and ligands
# the standard protocol is to use the pdb2pqr program, and use the amber force field
# However, to keep consistent with our simulations, which use the latest amber RNA force field
# the GAFF2 force field for lig, we will manually extract the 'charge' and 'vdW' information from 
# the Gromacs-generated input files, and generate the pdbqr files ourselves.



# the original atom name (i.e., HO5' ) and atom type (i.e., HO) are written in the RNAA.itp file

# and the vdw radi is from the amber parm file

# so we will combine informations from three files to obtaint the charge and radi information


rm -rf rna.pqr

#cp ../../amber-OL3RNA.parm_vdw_part .
#cp ../../amber-gaff2.parm_vdw_part .


RnaNumber=1082
LigNumber=37
LigName="TEP"


sed -i 's/N\*/NX/g' RNAA.itp

echo | awk '{
i=0
while ( ( getline < "amber-OL3RNA.parm_vdw_part" ) > 0 ) {
i++
if ( i >= 3 && i <= 67 ) {
	radi[$1]=$2
}
}


##!!!!! 
##!!!!! HERE need to change the "17" and "1082"

i = 0
while (( getline < "RNAA.itp" ) > 0 ) {
	i++
	if ( i >= 17 && i<= '$RnaNumber' ) {
		charge[$3,$5] = $7
		type[$3,$5] = $2
	}
}


while ( ( getline < "chainA.pdb" ) > 0 ) {
	printf "%s%8.4f%7.4f\n",substr($0,1,54),charge[$5,$3],radi[type[$5,$3]] >> "rna.pqr"
}
}'




rm -rf lig.pqr

# lig.pdb shoule be generated by "grep TEP step3_pbcsetup.pdb > lig.pdb" 

echo | awk '{
i=0
while ( ( getline < "amber-gaff2.parm_vdw_part" ) > 0 ) {
i++
if ( i >= 2 && i <= 97 ) {
        radi[$1]=$2
}
}

#HERE also need to change Ligand NAME, and line numbers
### 

i = 0
while (( getline < "'$LigName'.itp" ) > 0 ) {
        i++
        if ( i >= 17 && i<= '$LigNumber' ) {
                charge[$3,$5] = $7
                type[$3,$5] = $2
        }
}


while ( ( getline < "lig.pdb" ) > 0 ) {
        printf "%s%8.4f%7.4f\n",substr($0,1,54),charge[$5,$3],radi[type[$5,$3]] >> "lig.pqr"
}
}'





