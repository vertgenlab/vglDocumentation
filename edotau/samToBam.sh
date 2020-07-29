#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
set -e
module add samtools
SAM=$1
PREFIX=$(basename $SAM .sam)
OUT=${PREFIX}.bam
module add samtools
samtools sort -@ $SLURM_CPUS_ON_NODE $SAM > $OUT
samtools index $OUT
