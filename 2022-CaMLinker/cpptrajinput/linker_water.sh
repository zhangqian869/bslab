#!/bin/bash

# calculate the number of waters within 3 of protein




cat >> linker_water.tcl << EOD
# calculate the number of waters molecule within 3 A of linker 
mol new top.parm7
mol addfile ngamd1.nc waitfor -1
mol addfile ngamd2.nc waitfor -1
mol addfile ngamd3.nc waitfor -1
set frames [molinfo top get numframes]
set fp [open "linkerwaters.txt" w]
set protein "protein"
for {set i 0} {\$i < \$frames} {incr i} {
                puts "Frame: \$i"
                set a [atomselect top "(water within 3 of (resid 72 to 82) )" frame $i]
                set num [\$a num]
                puts \$fp "\$i \$num"
                \$a delete
}
close \$fp
EOD


vmd -dispdev text -eofexit < linker_water.tcl > out.log 
