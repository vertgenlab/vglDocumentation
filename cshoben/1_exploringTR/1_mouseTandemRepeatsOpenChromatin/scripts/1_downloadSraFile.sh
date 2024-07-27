#!/bin/bash
#SBATCH -J downloadSRAdata
#SBATCH -n 1
#SBATCH --mem 128G
#SBATCH -o outDownloadSRAdata%A.out
#SBATCH -e outDownloadSRAdata$A.err

module load SRA-Toolkit/2.9.6-1
fastq-dump --split-files --gzip $1
