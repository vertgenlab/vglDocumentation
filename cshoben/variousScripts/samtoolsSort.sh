#!/bin/bash
#SBATCH -J samtoolsSort
#SBATCH -n 1
#SBATCH --mem 50Gb
#SBATCH -e errSamtoolsSort.err

## Usage:Run this script with $1 being the reference genome name (ie mm10) and $2 being the SRR number of the sequence of interest. This script assumes you have already run the alignSeqToGenome.sh script and that you have the bam file within the expected script subdirectory (see the alignSeqToGenome.sh for what subdirectory you should expect) 

module load samtools
## $1 mm10 $2 SRR8119850
cd /data/lowelab/chelsea/scripts/alignSeqToGenome/alignOutput$1$2/
samtools sort $1$2.bam > $1$2_sorted.bam

