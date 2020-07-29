#!/bin/sh
#SBATCH --mem=20G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --nodes=1
#SBATCH --time=1-0
#SBATCH --job-name=gatk_haplotypeCaller
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=eric.au@duke.edu
set -e
BAM=$1
module load GATK samtools
REF=$2

PREFIX=$(basename $BAM .bam)
list=$(cat $REF | grep '>' | cut -d '>' -f 2)

for i in $list
do
	output=${PREFIX}.${i}.g.vcf.gz
	
	sbatch --mem=16G --exclude=dl-01 --cpus-per-task=4 --ntasks=1 --nodes=1 --time=1-06 --wrap="gatk HaplotypeCaller --input $BAM --output $output --reference $REF -ERC GVCF -G StandardAnnotation -G AS_StandardAnnotation -G StandardHCAnnotation -L $i"
done
exit 0
