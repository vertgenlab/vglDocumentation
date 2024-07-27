#!/bin/bash
#SBATCH -J prefetchSRAdata
#SBATCH -n 1
#SBATCH --mem 28G

## downloads and stores .sra files in $HOME/ncbi/public/sra/

echo "attempting to prefecth $1"
module load SRA-Toolkit/2.9.6-1
prefetch $1
