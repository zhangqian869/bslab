#!/bin/bash

# calculate the MMGBSA binding free energy between CaMBR and C-domain when the N-domain is devoid of Ca
cwd=`pwd`

cat > extract_cambr.trajin << EOD
trajin ngamd1.nc 1 -1 10
trajin ngamd2.nc 1 -1 10
trajin ngamd3.nc 1 -1 10
strip !:148-171
trajout cambr.traj
EOD
cpptraj -p x.top -i extract_cambr.trajin


# 2) extract cCaM/CaMBR trajectory (which is complex), the residue is :82-171
cat > extract_camcambr.trajin << EOD
trajin ngamd1.nc 1 -1 10
trajin ngamd2.nc 1 -1 10
trajin ngamd3.nc 1 -1 10
strip !:82-171
trajout camcambr.traj
EOD
cpptraj -p x.top -i extract_camcambr.trajin


# 3) extract the cCaM (which is the receptor). the resideu is :82-147
cat > extract_receptor.trajin << EOD
trajin ngamd1.nc 1 -1 10
trajin ngamd2.nc 1 -1 10
trajin ngamd3.nc 1 -1 10
strip !:82-147
trajout cam.traj
EOD
cpptraj -p x.top -i extract_receptor.trajin


# 4) now generete the corresponding topology files for DH, camcambr and complex.
cat > temp_trajin << EOD
parm x.top
parmstrip !:148-171
parmwrite out cambr.parm7
EOD

cpptraj -i temp_trajin

cat > temp_trajin << EOD
parm x.top
parmstrip !:82-171
parmwrite out camcambr.parm7
EOD

cpptraj -i temp_trajin

cat > temp_trajin << EOD
parm x.top
parmstrip !(:82-147)
parmwrite out receptor.parm7
EOD

cpptraj -i temp_trajin

# Now performe the MMGBSA calculation
cat > mmgbsa.in << EOD
&general
verbose=2, keep_files=0,
/
&gb
igb=5, saltcon=0.150,
/
&decomp
idecomp=2, dec_verbose=2,
/
EOD


MMPBSA.py -O -i mmgbsa.in -cp camcambr.parm7 -rp receptor.parm7 -lp cambr.parm7 -y camcambr.traj -yr cam.traj -yl cambr.traj

