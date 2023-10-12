#!/bin/bash

grep -v "#" lowd.gmds | awk '{ print $1,$2 }' > temp_project

/home/teliu/Apps/sketchmap-master/bin/dimproj -D 21 -d 2 -w -grid 1000,20,200 -fun-hd 18,8,6 -fun-ld 18,1,2 -gopt 5 -P landmark -p temp_project < hddata > FULL_PROJECTION
