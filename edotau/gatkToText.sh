#!/bin/sh
set -e
BAM=$1
SCRIPT=/data/lowelab/edotau/toGasAcu1.5/scripts/workerGatk.sh
REF=$2
#/data/lowelab/edotau/toGasAcu1.5/idx/stickleback_v5_assembly.fa
submitJobs=$3
#$(basename $BAM .bam).gatk.txt
touch $submitJobs
rm $submitJobs
list=$(cat $REF | grep '>' | cut -d '>' -f 2)
for i in $list
do
	
	echo "$SCRIPT $BAM $i $REF" >> $submitJobs
done
