#!/bin/bash
#SBATCH -e err_makeDB_%A.err

## $1 : path to reference fasta

##UPPERCASE=$(head -1000 $1 | tr [:lower:] [:upper:])
## this is important for unmasking repeats as many repeats are masked by being made lowercase

## echo '$1  was: ' $1

module load NCBI-BLAST/2.7.1
makeblastdb -in /hpc/group/vertgenlab/crs70/refGenomes/hg38/allUpper_hg38.fa \
       	-out hg38_blastdb -dbtype 'nucl' -hash_index
