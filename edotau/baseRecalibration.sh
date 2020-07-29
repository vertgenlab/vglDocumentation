#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --time=0-08
#SBATCH --job-name=RNA-Seq_baseRecal
#SBATCH --exclude=dl-01
set -e
BAM=$1
module load GATK samtools
REF=/data/lowelab/edotau/toGasAcu1.5/idx/stickleback_v5_assembly.fa
snpDb=/data/lowelab/edotau/toGasAcu1.5/RNA-Seq/hardFiltered/f1_hybrid_RNA-SEQ.HardFilter.SNP.sitesonly.vcf.gz
indelDb=/data/lowelab/edotau/toGasAcu1.5/RNA-Seq/hardFiltered/f1_hybrid_RNA-SEQ.HardFiltered.INDEL.sitesonly.vcf.gz
PREFIX=$(basename $BAM .Qc.bam)

recalBam=${PREFIX}.recal.bam

#NOTE: second known site argument is to mask certain varience

recalTable=${PREFIX}.recal_data.table
gatk BaseRecalibrator -R $REF --known-sites $snpDb --known-sites  $indelDb -I $BAM -O $recalTable

gatk ApplyBQSR -R $REF -I $BAM --bqsr-recal-file $recalTable -O $recalBam
#/data/lowelab/edotau/toGasAcu1.5/mataLitc/scripts/haplotype.sh $recalBam
submit=${PREFIX}.submit.txt
/data/lowelab/edotau/toGasAcu1.5/bepaRabs/baseRecalb/gatkToText.sh $recalBam $REF $submit
sbatch /data/lowelab/edotau/toGasAcu1.5/bepaRabs/baseRecalb/array.gatk.sh $submit
exit 0
