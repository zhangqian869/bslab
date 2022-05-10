#!/bin/bash

# Calculating the cross-correlation between the Calpha atoms of CaM residues

cat > dccmtrajin << EOD
parm x.top [traj]
parm cdomain.parm7 [cdomain] # C domain of PDB 3CLN
trajin ngamd1.nc parm [traj]
trajin ngamd2.nc parm [traj]
trajin ngamd3.nc parm [traj]
reference cdomain.crd parm [cdomain] [refff] # coordinate of C domain of PDB 3CLN
rms toCdomain :82-146@CA,C,N,O ref [refff] :1-65@CA,C,N,O out tt.dat
matrix name dccm correl :1-147@CA out distmat.dat
EOD

cpptraj -i dccmtrajin
