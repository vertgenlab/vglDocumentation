#!/bin/bash
#SBATCH -J CN1pat_lastZ
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem 10GB
#SBATCH -o out/%A_%a.out
command=$(head -${SLURM_ARRAY_TASK_ID} /work/yl726/PrimateT2T_15way/CN1pat.lastz.jobs.txt | tail -1)
srun $command