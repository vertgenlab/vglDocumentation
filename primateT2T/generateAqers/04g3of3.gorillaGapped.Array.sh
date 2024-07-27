#!/bin/bash
#SBATCH -J gorillaGapped_lastZ_3of3
#SBATCH -n 1
#SBATCH -N 1
#SBATCH --mem 10GB
#SBATCH -o out/%A_%a.out
command=$(head -${SLURM_ARRAY_TASK_ID} /work/yl726/PrimateT2T_15way/gorillaGapped.lastz.jobs.3of3.txt | tail -1)
srun $command
