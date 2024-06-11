#!/bin/bash
#SBATCH --job-name=scTheoA   # Job name
#SBATCH --ntasks=1                     #
#SBATCH --ntasks-per-node=1            #
#SBATCH --cpus-per-task=8              #
#SBATCH --mem=20gb                     # Job memory request
#SBATCH --gres=gpu:1                   # GPU request 


source /public/home/binsun/Apps/gromacs202205/bin/GMXRC








cwd=`pwd`
# test different hight, bfactor, sigma values

for i in `seq 1 80`
#for i in 1
do
cd $cwd && rm -rf $i && mkdir $i && cd $i



cp $cwd/input/plumed.dat .
cp $cwd/input/step3_input.pdb .
cp $cwd/input/metad_sim.mdp .
cp $cwd/input/newindx.ndx .



gmx grompp -f metad_sim.mdp -p $cwd/topol.top -c $cwd/equilibration.gro -o metad_sim.tpr -r $cwd/equilibration.gro -n newindx.ndx -maxwarn 1

gmx mdrun -deffnm metad_sim -plumed plumed.dat -v 2> metaddd.log
done

