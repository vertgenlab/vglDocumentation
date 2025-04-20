#!/bin/bash
#SBATCH -J gasAcu1.rabsTHREEspine.chain
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem 16GB
#SBATCH -o out/chain/jobname%A_linenumber%a.out
command=$(head -${SLURM_ARRAY_TASK_ID} gasAcu1.rabsTHREEspine.chaining_jobs.txt | tail -1)
srun $command
