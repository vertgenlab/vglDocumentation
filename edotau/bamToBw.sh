#!/bin/sh
set -e
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --nodes=1
#SBATCH --parsable
#SBATCH --time=0-8:00:00
module load bwa samtools
module load bedtools2/2.25.0-fasrc01
module load kentUtils/v302-gcb01
BAM=$1
chromSize=/data/lowelab/edotau/toGasAcu2RABS/gasAcu2RABS/gasAcu2RABS.sizes
DIR=$2
PREFIX=$(echo $BAM | sed 's/.bam//')
bed=$DIR/${PREFIX}.bed
BG=$DIR/${PREFIX}.bg
bamToBed -i $BAM > $bed
genomeCoverageBed -bg -i $bed -g $chromSize > $BG
bedGraphToBigWig $BG $SIZE $DIR/${PREFIX}.bw
rm $BG $bed
