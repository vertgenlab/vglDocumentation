#!/bin/bash

#SBATCH --mem 10G

## $1 input reference fasta
## $2 output path and filename for all upper case fasta

/hpc/home/crs70/go/bin/faFormat -toUpper=true /hpc/group/vertgenlab/crs70/refGenomes/hg38/hg38.fa /hpc/group/vertgenlab/crs70/refGenomes/hg38/allUpper_hg38.fa
