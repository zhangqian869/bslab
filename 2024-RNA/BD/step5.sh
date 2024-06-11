#!/bin/bash


# visulize the trajectories 

#for i in `seq 0 9`
for i in 0  # only extract the association trajectory from the first thread trajectory.
do
process_trajectories -traj Traj${i}.xml -index Traj${i}.index.xml -srxn association | grep \<number\> | awk '{ print $2}' > assoindex 

done


for i in `cat assoindex`
do
process_trajectories -traj Traj0.xml -index Traj0.index.xml -n $i > trajjj.xml


xyz_trajectory -mol0 rna.xml -mol1 lig.xml -trajf trajjj.xml > association_traj_thre0_${i}.xyz

rm trajjj.xml
done

#done
