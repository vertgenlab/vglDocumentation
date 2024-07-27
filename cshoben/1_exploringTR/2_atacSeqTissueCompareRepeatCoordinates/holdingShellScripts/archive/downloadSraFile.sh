#!/bin/bash
#SBATCH -J downloadSRAdata
#SBATCH -n 1
#SBATCH --mem 128G
#SBATCH -o outDownloadSRAdata%A.out
#SBATCH -e outDownloadSRAdata$A.err

cd /data/lowelab/chelsea/scripts/downloadSRAdata
module load sratoolkit
fastq-dump --split-files --gzip $1
