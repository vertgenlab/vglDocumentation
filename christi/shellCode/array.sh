#!/bin/bash
#SBATCH -J galGal6_pairwise_align
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH --mem 64GB
#SBATCH -o galGal6_pairwise_align%A_%a.out # Standard output
#SBATCH -e galGal6_pairwise_align%A_%a.err # Standard error (put in same file for this set of jobs)
command=$(head -${SLURM_ARRAY_TASK_ID} /data/lowelab/christi/innCon/multipleAlignment/galGal6AlignArray.txt | tail -1)
srun $command
