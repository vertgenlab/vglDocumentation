#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --nodes=1
#SBATCH --job-name=INDELs
set -e
module add GATK/4.1.0.0-gcb01
REF=/data/lowelab/edotau/toGasAcu2RABS/gasAcu2RABS/gasAcu2RABS.fasta
VCF=$1
PREFIX=$(basename $VCF .vcf.gz)

rawINDEL=${PREFIX}.raw.INDEL.vcf.gz
defaultINDEL=${PREFIX}.basic.Mark.vcf.gz
filterINDEL=${PREFIX}.HardFiltered.INDEL.vcf.gz
gatk --java-options "-Xmx16g" SelectVariants -R $REF -V $VCF -select-type INDEL -O $rawINDEL
gatk --java-options "-Xmx16g" VariantFiltration -R $REF -V $rawINDEL --filter-expression "QD < 2.0 || FS > 200.0 || ReadPosRankSum < -20.0" --filter-name "default_indel_filter" -O $defaultINDEL

gatk --java-options "-Xmx16g" SelectVariants -R $REF -V $defaultINDEL -exclude-filtered -O $filterINDEL
rm $defaultINDEL ${defaultINDEL}.tbi

