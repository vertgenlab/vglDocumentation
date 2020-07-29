#!/bin/sh
set -e
list=$(cat /data/lowelab/edotau/toGasAcu1.5/idx/stickleback_v5_assembly.fa | grep '>' | cut -d '>' -f 2)
for i in $list
do
	DIR=$i
	mkdir -p $DIR
	group=${i}".g.vcf.gz"
	mv *$group* $DIR
done
