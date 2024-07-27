#!/bin/bash
#SBATCH -J miniLastz
#SBATCH --mem 32GB
#SBATCH -o $1$2.out
#SBATCH -e $1$2.err


#$1 is target genome
#$2 is query genome

lastz=/hpc/group/vertgenlab/softwareShared/lastz-master/src/lastz
matrix=/hpc/group/vertgenlab/RefGenomes/hg38/lastzFiles/human_chimp_v2.mat

$lastz $1 $2 --output=$1$2.axt --scores=$matrix --format=axt O=600 E=150 T=2 M=254 K=4500 L=4500 Y=15000

echo lastz done, target $1 query $2 : input $0
