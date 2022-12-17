#!/bin/bash
#SBATCH -J multiFaToVcf
#SBATCH --mem 50GB
#SBATCH -e %AerrMultiFaToVcf%A_%a.err
#SBATCH -o %AoutMultiFaToVcf%A_%a.out

## Usage: Use gonomics multiFaToVcf.go to convert a multiFa to a VCF. Depends on a pairwise alignment. 
## input; $1 = multi.fa ;  $2 = chromName ;  $3 = out.vcf
## output is to this folder


/hpc/home/crs70/go/bin/multiFaToVcf $1 $2 $3
echo "multiFaToVcf.sh where input was: $1, $2, $3"
