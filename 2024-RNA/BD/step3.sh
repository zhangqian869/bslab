#!/bin/bash



# generate the reaction criteria xml file

cat > header << EOD
<roottag>
  <first-state> start </first-state>
  <reactions>
    <reaction>
      <name> association </name>
      <state-before> start </state-before>
      <state-after> end </state-after>
      <criterion>
        <n-needed> 3 </n-needed>
EOD



# for the theo apatmer, list all ligand's heavy atoms within the 
# selected atoms at the binding pocket entrance as pairs.
# NAMELY

# C8 C1'    G26 N2    A28 C1'      U24 O4     A28 N1    U6 C3'  A7 C5'





echo | awk '{

i=0
while ( ( getline < "lig.pqr" ) > 0 ) {

 if ( substr($0,14,1) != "H" ) { 
	 ligheavyatoms[i++] = $2
 }
}


j=0
while ( ( getline < "rna.pqr" ) > 0 ) {
        if ( $5 == 6 && $3 == "O2\047" ) { 
                bindsite[j++]=$2 }
        if ( $5 == 7 && $3 == "C5\047" ) {
                bindsite[j++]=$2 }
	if ( $5 == 8 && $3 == "C1\047" ) { 
		bindsite[j++]=$2 }
        if ( $5 == 24 && $3 == "O4" ) { 
                bindsite[j++]=$2 }
	if ( $5 == 26 && $3 == "N2" ) { 
		bindsite[j++]=$2 }
	if ( $5 == 28 && $3 == "C1\047" ) { 
		bindsite[j++]=$2 }
	if ( $5 == 28 && $3 == "N1" ) { 
		bindsite[j++]=$2 }
	if ( $5 == 28 && $3 == "N3" ) { 
		bindsite[j++]=$2 }
	}


M=i
N=j


 for(k=0;k<N;k++){
 	for(z=0;z<M;z++){
 		printf "%s\n","         <pair>"
 		printf "%s %s %s %s\n", "          <atoms>", bindsite[k], ligheavyatoms[z],"</atoms>"
 		printf "%s\n","          <distance> 5.000000 </distance>"
 		printf "%s\n","         </pair>"
 	}
 }
}' >> header


echo "      </criterion>" >> header
echo "    </reaction>" >> header
echo "</reactions>" >> header
echo "</roottag>" >> header


cp header rxn.xml


