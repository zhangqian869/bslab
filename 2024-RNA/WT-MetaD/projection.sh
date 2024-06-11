#!/bin/bash

#projection of WT-MetaD trajs onto the COM distance, and coordination number (CN) plane

cwd=`pwd`

for i in `seq 1 80`
do
	cd $cwd/$i

plumed driver --mf_xtc metad_sim.xtc --mc $cwd/input/mcfile --plumed $cwd/input/reweight.dat
done
