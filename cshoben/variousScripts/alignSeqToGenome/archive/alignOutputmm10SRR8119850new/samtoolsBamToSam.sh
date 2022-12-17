#!/bin/bash
#SBATCH -J samtoolsSort # A single job name for the array
#SBATCH -n 2 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH --mem 64GB
#SBATCH -e errSamtoolsSort%A_%a.err



cd /data/lowelab/chelsea/scripts/alignSeqToGenome/alignOutputmm10SRR8119850new
module load samtools
samtools view  mm10SRR8119850new.mem.sorted.bam > VIEW.mm10SRR8119850new.mem.sorted.sam

