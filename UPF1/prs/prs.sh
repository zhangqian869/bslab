#!/bin/bash

# conda activate PRS environment

prs=/home/binsun/Apps/PRS/MD-TASK-master/noAlign_prs.py
net=/home/binsun/Apps/PRS/MD-TASK-master/calc_network.py



# Here the steady.dcd is at the last of the cMD where the standard deviation of RMSD is around 2 AA, which indicates that the simulation is stable


#---- First align all structures to the pdb 2XZP (APO's) secondary elements in the RecA2 domain
# resid 407-417, 447-451,468-484,491-495,498-511,537-541,557-564, 570-575,584-595




cat > header << EOD
596
Created with in house scripts, 2022-09-17
EOD


awk '{ if ( $3 == "CA" ) print }' aligned_2xzo_RNA_ATP.pdb | awk '{

printf "%2s%9.3f%9.3f%9.3f\n","CA",$6,$7,$8 >> "header"
}'

mv header final.xyz


# align the trajectory, the trajectory should also be aligned to pdb 2XZP



cat > temptrajin << EOD
parm step3_input.psf [md]
trajin run1.dcd 5000 7678 parm [md] # the last 200 ns
trajin run2.dcd 5000 7678 parm [md] # the last 200 ns
reference 2xzp.pdb ref [refff]
rms toRecA2 :407-417,447-451,468-484,491-495,498-511,537-541,557-564,570-575,584-595@CA ref [refff] :407-417,447-451,468-484,491-495,498-511,537-541,557-564,570-575,584-595@CA out rmsd
strip !:1-596
trajout aligned_2xzp.dcd
EOD


cpptraj -i temptrajin

grep "PROA"  step3_input.pdb > top.pdb

# get the first frame of the aligned trajectory as the initial xyz

cat > trajin2 << EOD
trajin aligned_2xzp.dcd 1 1
trajout ini.pdb
EOD

cpptraj -p top.pdb -i trajin2

cat > header << EOD
596
Created with in house scripts, 2022-09-17
EOD


awk '{ if ( $3 == "CA" ) print }' 2xzp.pdb | awk '{

printf "%2s%9.3f%9.3f%9.3f\n","CA",$6,$7,$8 >> "header"
}'

mv header initial.xyz


 python $prs --initial initial.xyz --final final.xyz --perturbations 100 --step 10 --prefix result --topology top.pdb aligned_2xzp.dcd




# python $net --topology wt.pdb --threshold 7.0 --step 100 --generate-plots --calc-BC --calc-L --discard-graphs --lazy-load wt.dcd




