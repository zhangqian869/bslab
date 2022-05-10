#!/bin/bash

# Intradomain hbond analysis, secondary structure, linker strain 

cat > domainhbtrajin << EOD
parm x.top [traj]
trajin ngamd1.nc parm [traj]
trajin ngamd2.nc parm [traj]
trajin ngamd3.nc parm [traj]
energy ene :72-82@CA,C,N,O out linkerEne.dat bond angle dihedral # linker strain energy
secstruct Nsecdata out Nsecs.dat :1-70 sumout Nsecs.out assignout Nsecstruct.assign totalout Nsecstruct.totalout
secstruct Csecdata out Csecs.dat :80-147 sumout Csecs.out assignout Csecstruct.assign totalout Csecstruct.totalout
radial out cardf.dat 0.5 50 :CA :26-28,62-64@CA,C,N,O intrdf intcardf.dat # radial distribution of ca2+ around N-domain EF-hands
hbond :1-69 out NNnhb.dat avgout NNavghb.dat series uuseries NNuuhbonds.agr
hbond :70-85 out LLnhb.dat avgout LLavghb.dat series uuseries LLuuhbonds.agr
hbond :86-147 out CCnhb.dat avgout CCavghb.dat series uuseries CCuuhbonds.agr
EOD

cpptraj -i domainhbtrajin
