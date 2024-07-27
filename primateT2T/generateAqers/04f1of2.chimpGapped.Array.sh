#!/bin/bash
#SBATCH -J chimpGapped_lastZ_1of2
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem 10GB
#SBATCH -o out/%A_%a.out
command=$(head -${SLURM_ARRAY_TASK_ID} /work/yl726/PrimateT2T_15way/chimpGapped.lastz.jobs.1of2.txt | tail -1)
srun $command
