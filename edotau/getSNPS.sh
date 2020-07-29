#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --nodes=1
#SBATCH --job-name=GVcfToSNPs
set -e
module add GATK/4.1.0.0-gcb01
REF=/data/lowelab/edotau/toGasAcu2RABS/gasAcu2RABS/gasAcu2RABS.fasta
VCF=$1
PREFIX=$(basename $VCF .vcf.gz)
rawSNP=${PREFIX}.raw.SNP.vcf.gz
defaultFilter=${PREFIX}.marked.basic.SNP.vcf.gz
filterSNP=${PREFIX}.Filtered.SNP.vcf.gz
gatk --java-options "-Xmx16g" SelectVariants -R $REF -V $VCF -select-type SNP -O $rawSNP
#gatk --java-options "-Xmx16g" VariantFiltration -R $REF -V $rawSNP --filter-expression "QD < 2.0 || FS > 60.0 || MQ < 40.0 || MQRankSum < -12.5 || ReadPosRankSum < -8.0" --filter-name "default_snp_filter" -O $defaultFilter
#gatk --java-options "-Xmx16g" SelectVariants -R $REF -V $defaultFilter --exclude-filtered -O $filterSNP
#rm $defaultFilter ${defaultFilter}.tbi
