#!/bin/sh
set -e
REF=/data/lowelab/edotau/toGasAcu1.5/idx/stickleback_v5_assembly.fa
files=samples.txt
#touch $files
#rm $files
#for i in *.Genotyped.vcf.gz; do echo "$i" >> $files; done
module add GATK
gatk GatherVcfs -I $files -R $REF -O $1
