#!/bin/bash
#
#SBATCH --job-name=mapReads
#SBATCH --ntasks=1
#SBATCH --partition common
#SBATCH --array=1-350
#SBATCH --cpus-per-task=12
#SBATCH --mem=14G
#SBATCH --output=outError/map.%A_%a.out 
#SBATCH --error=outError/map.%A_%a.error

LINE=$(sed -n "$SLURM_ARRAY_TASK_ID"p mappingJobs.list)
echo $LINE

./mapReads.csh $LINE

echo "outer bash done"
