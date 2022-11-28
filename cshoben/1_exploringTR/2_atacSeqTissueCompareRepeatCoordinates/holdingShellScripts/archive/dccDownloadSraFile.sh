#!/bin/bash
#SBATCH -J downloadSRAdata
#SBATCH -n 1
#SBATCH -o outDownloadSRAdata%A.out
#SBATCH -e outDownloadSRAdata%A.err

cd /hpc/group/vertgenlab/crs70/scripts/downloadSRAdata
module load SRA-Toolkit/2.9.6-1
fastq-dump --split-files --gzip $1
