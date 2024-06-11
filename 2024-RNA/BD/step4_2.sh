#!/bin/bash




 nam_simulation rna-lig-simulation.xml


 cat results.xml | compute_rate_constant
