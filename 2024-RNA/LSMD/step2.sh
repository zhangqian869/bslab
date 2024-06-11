#!/bin/bash


# the charmm-gui generated gromacs force field use the 
# comb_rule = 2, i.e., sigma, epsilon values for each atom type



# 
source /home/binsun/Apps/gromacs2019/bin/GMXRC

GMX="/home/binsun/Apps/gromacs2019/bin/gmx"

cwd=`pwd`

for i in `seq 0 49`
#for i in 1
do
	cd $cwd/mdv1_${i}

	cp $cwd/input/temp.mdp run.mdp
	cp $cwd/input/newindex.ndx .
	cp $cwd/input/table6-12.xvg mdv1_${i}.xvg

	previous=$((i-1))

	steps=50000 # 0.1 ns
	tinit=`echo | awk '{ print '$steps'*'$i'*0.002 }'`
	sed -i 's/XXX/'$tinit'/g' run.mdp

# checkpoint files:
if [ $i -eq 0 ]
then
	# use the checkpoint of 10 ns produmction run
	cp $cwd/input/production_prev.cpt start.cpt
        cp $cwd/input/production.gro start.gro

$GMX grompp -quiet -n newindex.ndx -f run.mdp -c start.gro  -p ../topol.top -o mdv1_${i}.tpr
else
	cp $cwd/mdv1_${previous}/mdv1_${previous}.cpt start.cpt
	cp $cwd/mdv1_${previous}/mdv1_${previous}.gro start.gro

$GMX   	grompp -quiet -n newindex.ndx -f run.mdp -c start.gro  -t start.cpt -p ../topol.top -o mdv1_${i}.tpr
fi


$GMX mdrun -quiet -notunepme -pin on -pinoffset 0 -ntomp 1 -ntmpi 20 -deffnm mdv1_${i}



done


 
