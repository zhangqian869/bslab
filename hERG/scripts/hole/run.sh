#!/bin/bash


HOLE="/home/binsun/Apps/hole2/exe/hole"


cat > hole.inp << EOD
! example input file run on Arseniev's gramicidin structure
! note everything preceded by a "!" is a comment and will be ignored by HOLE
!
! follow instructions in doc/index.html to run this job
!
! first cards which must be included for HOLE to work
! note that HOLE input is case insensitive (except file names)
coord test.pdb           ! Co-ordinates in pdb format
radius /home/binsun/Apps/hole2/rad/simple.rad   ! Use simple AMBER vdw radii
                                ! n.b. can use ~ in hole
!
! now optional cards
sphpdb hole_out.sph             ! pdb format output of hole sphere centre info
                                ! (for use in sph_process program)
endrad 5.                       ! This is the pore radius that is taken
                                ! as where channel ends. 5.0 Angstroms is good
                                ! for a narrow channel
EOD


n=0
for i in `cat list`
do
	final=$((i+1533))
	n=$((n+1))
	awk '{ if ( NR >= '$i' && NR <= '$final' ) print }' pore.pdb > test.pdb


$HOLE < hole.inp > hole_${n}.log
rm hole_out.sph
done
