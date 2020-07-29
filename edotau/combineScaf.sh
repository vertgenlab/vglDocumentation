#!/bin/sh
set -e
list=$(cat /data/lowelab/edotau/RABSGenome/idx/refdata-RABS.hiCanu10xScaf.2.4/fasta/genome.fa | grep '>' | cut -d '>' -f 2)
for i in $list
do
	sbatch ./combineGVCF.sh $i $i
done
