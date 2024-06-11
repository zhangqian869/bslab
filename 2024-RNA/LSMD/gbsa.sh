#!/bin/bash

cwd=`pwd`

for i in `seq 0 49`
do
	cd $cwd/mdv1_${i} && rm -rf GBSA && mkdir GBSA && cd GBSA

cp $cwd/GBSAinput/* .

gmx_MMPBSA -O -i mmpbsa.in -cs ../mdv1_${i}.tpr -ct ../mdv1_${i}.xtc -ci newindex.ndx -cg 3 4 -cp $cwd/topol.top -o FINAL_RESULTS_MMPBSA.dat -eo FINAL_RESULTS_MMPBSA.csv  -nogui
done
