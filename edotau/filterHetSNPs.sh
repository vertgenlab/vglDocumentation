#!/bin/sh
vcf=$1
PREFIX=$(echo $vcf | sed 's/.haplotypecaller.vcf//')
cat $vcf | grep -e '#' -e '	0/1' > ${PREFIX}.het.vcf
module load tabix
bgzip ${PREFIX}.het.vcf
tabix -p vcf ${PREFIX}.het.vcf.gz
