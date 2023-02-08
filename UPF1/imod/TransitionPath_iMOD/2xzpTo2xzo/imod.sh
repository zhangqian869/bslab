#!/bin/bash

# for every dRMSD 0.5A (Calpha atom),  save one frame

# "HE" will fix the dihedrals corresponding
#     to alpha-helices and beta-sheets. 


imorph_gcc amber_2xzp.pdb amber_2xzo.pdb -S "HE"
