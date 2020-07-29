#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=4
#SBATCH --nodes=1
#SBATCH --job-name=atacSNPs
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=eric.au@duke.edu
module load GATK/4.1.3.0-gcb01
module load R gnuplot/4.6.4-fasrc02
REF=/data/lowelab/edotau/toGasAcu1.5/idx/stickleback_v5_assembly.fa
#NOTES: THIS IS THE BEST IMPLEMENTATION
#hetsMATAxLITC=/data/lowelab/edotau/master/LITCxMATA/truth/LITCxMATA.cohort.ASGenotypes.sitesonly.vcf.gz

#hetsRABSxBEPA=/data/lowelab/edotau/master/RABSxBEPA/truth/BEPAxRABS.cohort.ASGenotypes.sitesonly.vcf.gz

snpDb=/data/lowelab/edotau/toGasAcu1.5/gvcfs_all_mataLitcRabsBepa/truthsites/MataBepaRabsLitc.cohort_1stPass.HardFilter.SNP.sitesonly.vcf.gz

VCF=$1
PREFIX=$(basename $VCF .vcf.gz)
VQSR=${PREFIX}.SNPs.training.VQSR.vcf.gz
tranches=${PREFIX}.SNPs.tranches
RSCRIPT=${PREFIX}.SNPs.plots.R
gatk VariantRecalibrator -R $REF -V $VCF \
	-resource:atacHetsLITCxMATA,known=false,training=true,truth=true,prior=8.0 $snpDb \
	-an AS_FS -an AS_ReadPosRankSum -mode SNP --tranches-file $tranches --rscript-file $RSCRIPT \
	-tranche 100.0 -tranche 99.9 -tranche 99.0 -tranche 90.0 -O $VQSR
FINAL=${PREFIX}.SNPs.VQSR.99.0_FINAL.vcf.gz
gatk ApplyVQSR -R $REF -V $VCF -mode SNP -ts-filter-level 99.0 -recal-file $VQSR --tranches-file $tranches -O $FINAL
