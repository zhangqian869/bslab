#!/bin/bash
#SBATCH --job-name=WinXXX    # Job name
#SBATCH --ntasks=1                     #
#SBATCH --ntasks-per-node=1            #
#SBATCH --cpus-per-task=8              #
#SBATCH --mem=20gb                     # Job memory request
#SBATCH --gres=gpu:1                   # GPU request 
#SBATCH --time=24:00:00                # Time limit hrs:min:sec



#compiled NAMD_2.14_Linux-x86_64-multicore-CUDA fron source code
namd2="/public/Apps/NAMD/Source/NAMD_2.14_Source/Linux-x86_64-g++/namd2"



$namd2 +p8 +setcpuaffinity +devices $CUDA_VISIBLE_DEVICES md.inp > md.out



