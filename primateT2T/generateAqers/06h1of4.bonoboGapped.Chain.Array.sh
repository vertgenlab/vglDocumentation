#!/bin/bash
#SBATCH -J bonoboGapped_chain_1of4
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem 16GB
#SBATCH -o out/chain/jobname%A_linenumber%a.out
command=$(head -${SLURM_ARRAY_TASK_ID} /work/yl726/PrimateT2T_15way/bonoboGapped.chaining_jobs.1of4.txt | tail -1)
srun $command
