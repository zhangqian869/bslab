#!/bin/bash


rm -rf metadata




for i in `seq 0 51`
	do
	for j in `seq 2 7`
	do

cp ../h0${j}/win${i}.colvars.traj ${i}_${j}.traj


xcenter=`echo | awk '{ print -13.0 + '$i'*0.5 }'`
ycenter=`echo | awk '{ print '$j'*0.1 }'`



grep -v "#" ${i}_${j}.traj | awk '{ if ( NR >= 100) printf "%12d %8.2f %8.2f\n", $1,$2,$3}' > ${i}_${j}.dat


echo "${i}_${j}.dat $xcenter $ycenter 16.00 1000" >> metadata 

done
done




#/home/binsun/App/wham/wham/wham -13.0 12.5 52 0.00001 300 0 metadata results.dat
/home/binsun/App/wham/wham-2d/wham-2d Px=0 -13.0 12.5 52 Py=0 0.2 0.7 6 0.00001 300 0 metadata results 1
