#!/bin/sh
module add bedtools2/2.25.0-fasrc01 coreutils/8.25-gcb01
echo "Converting bam to bed"
bed=HiC_Sacff10x_merge_nodups.final.bed

bamToBed -i $1 > hicScaf10x.bed
sort -k 4 hicScaf10x.bed -T $PWD --parallel=$SLURM_CPUS_ON_NODE > $bed
