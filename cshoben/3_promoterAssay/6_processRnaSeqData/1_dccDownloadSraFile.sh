#!/bin/bash
#SBATCH -J downlSRAdata
#SBATCH -n 1
#SBATCH --mem 32G


echo "attempting to download $1"
module load SRA-Toolkit/2.9.6-1
fasterq-dump $1
