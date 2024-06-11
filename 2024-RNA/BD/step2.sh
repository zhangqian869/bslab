#!/bin/bash


# apbs 

cat lig.pqr | /home/binsun/Apps/browndye/bin/pqr2xml  > lig.xml
cat rna.pqr | /home/binsun/Apps/browndye/bin/pqr2xml  > rna.xml


apbs rna_apbs.in
apbs lig_apbs.in
