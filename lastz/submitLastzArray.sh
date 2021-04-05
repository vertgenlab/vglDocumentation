#!/bin/bash
#SBATCH -J balMus1_lastZ
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem 32GB
#SBATCH -o jobname%A_%a.out
#SBATCH -e jobname%A_%a.err
command=$(head -${SLURM_ARRAY_TASK_ID} lastz_jobs.txt | tail -1)
srun $command
