#!/bin/bash


rm -rf wisp_out


# ATP_binding residues

#ress1="A_LYS_199 A_ASP_337 A_GLN_366 A_ARG_404 A_ARG_566"
ress1="A_LYS_199"
#ress1="A_GLU_284" 
ress2="A_THR_47 A_GLY_60 A_GLU_91 A_LYS_83" 

cat > trajin << EOD
parm step3_input.psf [md]
trajin run1.dcd 1 -1 50 parm [md]
trajin run1b.dcd 1 -1 50 parm [md] 
trajin run2.dcd 1 -1 50 parm [md]
trajin run2b.dcd 1 -1 50 parm [md] 
reference 2xzp.pdb ref [refff]
rms toRecA2 :407-417,447-451,468-484,491-495,498-511,537-541,557-564,570-575,584-595@CA ref [refff] :407-417,447-451,468-484,491-495,498-511,537-541,557-564,570-575,584-595@CA out rmsd
strip !:1-596@CA
trajout wisp.pdb 
EOD


cpptraj -i trajin


# remove Hydrogen
awk '{ if ( substr($NF,1,1) != "H") {
if ( $1 == "ATOM" ) {
	printf "%s%s%s\n",substr($0,1,21),"A",substr($0,23) }
		else print 
		}
	}' wisp.pdb > t
		mv t wisp.pdb

# conda activate wisp

# 

WISP="/home/binsun/Apps/wisp-1.3/wisp.py"

python $WISP -contact_map_distance_limit 4.5 -desired_number_of_paths 500 \
        -load_wisp_saved_matrix FALSE -longest_path_b 0.0 -longest_path_g 0.0 \
	-longest_path_opacity 1.0 -longest_path_r 1.0 -longest_path_radius 0.01 \
	-node_definition CA -node_sphere_b 1.0 -node_sphere_g 1.0 \
       	-node_sphere_opacity 1.0 -node_sphere_r 1.0 -node_sphere_radius 1.0 \
	-num_frames_to_load_before_proceesing 20 -number_processors 16 -pdb_trajectory_filename wisp.pdb  -seconds_to_wait_before_parallelizing_path_finding 5.0 \
	-shortest_path_b 1.0 -shortest_path_g 0.0 -shortest_path_opacity 1.0 \
	-shortest_path_r 0.0 -shortest_path_radius 1.0 \
	-sink_residues "$ress2" \
	-source_residues "$ress1" \
	-spline_smoothness 0.01 -vmd_resolution 6 -output_directory wisp_out

