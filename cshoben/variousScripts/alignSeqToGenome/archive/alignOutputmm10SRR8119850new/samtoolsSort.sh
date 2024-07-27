#!/bin/bash
#SBATCH -J samtoolsSort # A single job name for the array
#SBATCH -n 2 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH --mem 64GB
#SBATCH -e errSamtoolsSort%A_%a.err

## Usage: input an unsorted sam file, and samtools sort will sort (no flags declared in this script). Since output of "samtools sort" is a bam file, run through samtools view and funnel into a file with ".sam" and we will then have an output sam file that is sorted. This script was written without arguments, needs updated. 

cd /data/lowelab/chelsea/scripts/alignSeqToGenome/alignOutputmm10SRR8119850new
module load samtools
samtools sort mm10SRR8119850new.mem.sam | samtools view > sorted.mm10SRR8119850new.mem.sam

