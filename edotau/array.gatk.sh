#!/bin/bash
#SBATCH --mem=16G
#SBATCH --ntasks=2 --cpus-per-task=2
#SBATCH --job-name=SNPs_toGenotype
#SBATCH --array=1-22
#SBATCH --exclude=dl-01
#SBATCH --time=1-0
#SBATCH --nodes=1
set -e
#uses a text file as the only input, must know the number of lines ahead of time
command=$(head -${SLURM_ARRAY_TASK_ID} $1 | tail -1)
srun $command
