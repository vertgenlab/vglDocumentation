#!/bin/sh
set -e
module add GATK
BAM=$1
i=$2
REF=$3
PREFIX=$(basename $BAM .bam)
output=${PREFIX}.${i}.g.vcf.gz
gatk HaplotypeCaller --input $BAM --dont-use-soft-clipped-bases true --output $output --reference $REF -G StandardAnnotation -G AS_StandardAnnotation -G StandardHCAnnotation -ERC GVCF -L $i
