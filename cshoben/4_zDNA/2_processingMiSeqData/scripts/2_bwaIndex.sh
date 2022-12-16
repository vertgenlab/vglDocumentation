#!/bin/bash
#SBATCH --mem=10G

## $1 is the path to the ref.fa

/hpc/group/vertgenlab/crs70/software/bwa/bwa-0.7.17/bwa index -a bwtsw $1


