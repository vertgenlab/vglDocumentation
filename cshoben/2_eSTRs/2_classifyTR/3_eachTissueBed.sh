#!/bin/bash

cat /hpc/group/vertgenlab/crs70/projects/eSTRs/eSTRs/raw/master/Brain-Cerebellum_master.tab | \
awk 'BEGIN {FS="\t"; OFS=FS} {print $1, $3, $8, $2}' | \
tail -n +2 > \
brainCerebellumEstrGene.bed
