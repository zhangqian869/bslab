
# align the bonds between to atoms along the X axis

# "transvecinv" is to align vector along x axis

proc alignbond {ind1 ind2} {
set atm1 [atomselect top "serial $ind1"]
set atm2 [atomselect top "serial $ind2"]
set vecx [expr [$atm2 get x] - [$atm1 get x]]
set vecy [expr [$atm2 get y] - [$atm1 get y]]
set vecz [expr [$atm2 get z] - [$atm1 get z]]
set sel [atomselect top all]
$sel move [transvecinv "$vecx $vecy $vecz"]
}



# set sel [atomselect top all]

# $sel move [transaxis z 90]

