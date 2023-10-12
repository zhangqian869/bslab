#!/bin/bash 
  
rm -rf metafile
rm -rf result.dat

for i in `seq 0 60`
do
        center=`echo | awk '{ print 26.5+'$i'*0.5}'`

        echo ''$i'.dat '$center' 20' >> metafile
done

wham 26.5 56,5 61 0.0001 300 0 metafile result.dat 10 12
