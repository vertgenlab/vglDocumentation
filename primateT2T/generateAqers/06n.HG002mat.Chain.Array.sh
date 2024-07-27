#!/bin/bash
#SBATCH -J HG002mat_chain
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem 16GB
#SBATCH -o out/chain/jobname%A_linenumber%a.out
command=$(head -${SLURM_ARRAY_TASK_ID} /work/yl726/PrimateT2T_15way/HG002mat.chaining_jobs.txt | tail -1)
srun $command
