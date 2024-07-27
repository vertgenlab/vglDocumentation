#!/bin/bash
#SBATCH -J bamToSam
#SBATCH -n 1
#SBATCH --mem 100G
#SBATCH -o outSam%A.out
#SBATCH -e errSam%A.err

##USAGE: 
##$1 - bam file full path 


module load samtools/1.10
samtools view -h $1 > $1.sam 
echo "$0  where input was: $1"
