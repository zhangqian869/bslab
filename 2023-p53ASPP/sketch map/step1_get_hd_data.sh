#!/bin/bash


# the high dimentional (D=21) CV are the minimum 
# distance between residue pairs from p53 (1-191) and
# aspp2 (192-384)


# This script requires the MD trajectory and topology. in this case
# it is 'stable.xtc' and 'parm7'
# the output file is 'hddata'

FRG1='10 29 62 82 110 135 172 177 184 188'
FRG2='198 210 231 243 264 276 297 314 352 372 378'

# Step1 -- Calculate the distance between C alpha of each residue 
# in FRG1(2) to that of FRG2(1)

for i in $FRG1
 do
n=0
rm -rf trajin${i}
cat >> trajin${i} << EOD
parm ../struc.pdb
trajin ../stable.xtc
EOD

   for j in $FRG2
   do
n=$((n+1))
cat >> trajin${i} << EOD
distance d${n} :${i}@BB :${j}@BB out dis${i}.dat
EOD
done
cpptraj -i trajin${i}
done


for i in $FRG2
 do
n=0
rm -rf trajin${i}
cat >> trajin${i} << EOD
parm ../struc.pdb
trajin ../stable.xtc
EOD

   for j in $FRG1
   do
n=$((n+1))
cat >> trajin${i} << EOD
distance d${n} :${i}@BB :${j}@BB out dis${i}.dat
EOD
done
cpptraj -i trajin${i}
done

# Step2 -- Calculate the miminum distance between Ca of FRG1 to ANY Ca of FRG2
rm -rf cmd
echo | awk '{ printf "%s ","paste" }' >> cmd

for i in $FRG1 $FRG2
 do
echo | awk '{
i=0
while (( getline < "dis'$i'.dat" ) > 0 ) {
i++
if ( i > 1 ) {
mini = 100
for(k=2;k<=NF;k++){
 if ( $k <= mini )   mini = $k
 }
 print mini 
}
}
}' > new${i}

echo | awk '{ printf "%s ","new'$i'" }' >> cmd
done

echo | awk '{ printf "%s ",">> hddata" }' >> cmd
bash cmd
rm new* dis*
rm -rf trajin*
