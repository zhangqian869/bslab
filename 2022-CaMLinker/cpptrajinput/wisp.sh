#!/bin/bash

# WISP requests to first align structure and then save as pdb format

NPATH=100
SOR="X_THR_70" #Source residues
SIK="X_ILE_85" # Sink residues
INPUT=wisp_input.pdb
OUTPUT=wisp_out
Nprocs=2   #number of processers 



# align the fragment from sink to source residue
cat > algintrajin << EOD
parm x.top [traj]
trajin ngamd1.nc parm [traj] 700 1300 10
trajin ngamd2.nc parm [traj] 700 1300 10
trajin ngamd3.nc parm [traj] 700 1300 10
rms first :70-85@CA,C,N,O out tt.dat
strip !:60-95
trajout wisp_input.pdb
EOD

cpptraj -i algintrajin


IDD=`grep -n "ENDMDL" wisp_input.pdb | tail -n 1 | awk -F ":" '{ print $1 }'`


 awk '{ if ( NR != '$IDD') { if ( $1 == "ATOM" ) { printf "%s%s%s\n",substr($0,1,21),"X",substr($0,23) } else print } }' wisp_input.pdb > t.pdb
 mv t.pdb wisp_input.pdb

 # the wisp is pre-installed 
python /home/binsun/Apps/WISP/wisp-1.3/wisp.py  -contact_map_distance_limit 4.5 -desired_number_of_paths 100 -load_wisp_saved_matrix FALSE -longest_path_b 0.0 -longest_path_g 0.0 -longest_path_opacity 1.0 -longest_path_r 1.0 -longest_path_radius 0.01 -node_definition CA -node_sphere_b 0.0 -node_sphere_g 0.0 -node_sphere_opacity 1.0 -node_sphere_r 1.0 -node_sphere_radius 1.0 -num_frames_to_load_before_processing 96 -number_processors 1 -output_directory wisp_out/ -pdb_trajectory_filename wisp_input.pdb -seconds_to_wait_before_parallelizing_path_finding 5.0 -shortest_path_b 1.0 -shortest_path_g 0.0 -shortest_path_opacity 1.0 -shortest_path_r 0.0 -shortest_path_radius 0.1 -sink_residues "X_ILE_85" -source_residues "X_THR_70" -spline_smoothness 0.01 -vmd_resolution 6

