#!/bin/bash
#SBATCH -J bedToBigBed
#SBATCH --mem 10G


## $1 -- define the type (-type=bed3+5)
## $2 -- path to file.bed (must be sorted) 
## $3 -- path to reference.chrom.sizes (mm10, hg19, etc.)
## $4 -- outputName.bb

/hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed $1 $2 $3 $4
