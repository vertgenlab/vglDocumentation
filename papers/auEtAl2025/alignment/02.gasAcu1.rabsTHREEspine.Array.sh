#!/bin/bash
#SBATCH -J gasAcu1.rabsTHREEspine_lastZ
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem 3GB
#SBATCH -o out/%A_%a.out
command=$(head -${SLURM_ARRAY_TASK_ID} gasAcu1.rabsTHREEspine.lastz.jobs.txt | tail -1)
srun $command

# target: gasAcu1
# query: rabsTHREEspine
