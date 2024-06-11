import os
from os.path import join
import numpy

def gen_xvgtable(coulomb_scale=1, c6_scale=1, c12_scale=1, cwd='', name=''):
    fmt = "%12.10e   %12.10e %12.10e   %12.10e %12.10e   %12.10e %12.10e\n"
    with open(join(cwd, name+'_nucleic_Lig.xvg'), 'w') as outfile:
        outfile.write("#\n# LJ 6-12 Potential\n#\n")
        for r in numpy.arange(0, 2.104, 0.002):
            if r<0.04:
                outfile.write(fmt % (r,0.0,0.0,0.0,0.0,0.0,0.0))
            else:
                f = coulomb_scale/r
                fprime = coulomb_scale/r**2
                g = -c6_scale/r**6
                gprime = -6*c6_scale/r**7
                h = c12_scale/r**12
                hprime = 12*c12_scale/r**13
                outfile.write(fmt % (r,f,fprime,g,gprime,h,hprime))



l1 = [1.0, 0.975, 0.95, 0.925, 0.9, 0.875, 0.85, 0.825, 0.8, 0.775, 0.75, 0.725, 0.7, 0.675, 0.65, 0.625, 0.6, 0.575, 0.55, 0.525, 0.5, 0.475, 0.45, 0.425, 0.4, 0.375, 0.35, 0.325, 0.3, 0.275, 0.25, 0.225, 0.2, 0.175, 0.15, 0.125, 0.1, 0.075, 0.05, 0.025, 0.0]
zerolist = [0 for i in range(9)]
l1.extend(zerolist)

for nameidx, s in enumerate(l1):
        #make subdir 
        dirname = 'mdv1_' +str(nameidx)
        os.mkdir(dirname)
        cwd = join(os.getcwd(), dirname)
        #make xvg files
        gen_xvgtable(s, s, 1, cwd, dirname)


