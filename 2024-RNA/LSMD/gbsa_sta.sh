#!/bin/bash

cwd=`pwd`

rm -rf allEinter*
touch allEinter_gas allEinter_delta

#for i in `seq 0 49`
	for i in `seq 0 49`
do
	cd $cwd/mdv1_${i}/GBSA

	awk -F "," '{ if ( NR >= 316 && NR <= 416 ) {
	print $1+'$i'*101, $11 
}
}' FINAL_RESULTS_MMPBSA.csv >> $cwd/allEinter_gas


	awk -F "," '{ if ( NR >= 316 && NR <= 416 ) {
	print $1+'$i'*101, $13 
}
}' FINAL_RESULTS_MMPBSA.csv >> $cwd/allEinter_delta
done
