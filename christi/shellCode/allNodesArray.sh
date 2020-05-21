#!/bin/bash
#SBATCH -J all_nodes_CNEE_peaks
#SBATCH -n 1 # Number of cores
#SBATCH -N 1 # All cores on one machine
#SBATCH --mem 64GB
#SBATCH -o all_nodes_CNEE_peaks%A_%a.out # Standard output
#SBATCH -e all_nodes_CNEE_peaks%A_%a.err # Standard error (put in same file for this set of jobs)
command=$(head -${SLURM_ARRAY_TASK_ID} /data/lowelab/christi/innCon/findPeaks/allNodesIndChrOverlapByWindow.txt | tail -1)
srun $command
