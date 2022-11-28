#!/bin/bash
#SBATCH -J wigToBigWig
#SBATCH --mem 64GB


/data/lowelab/cl454/bin/x86_64/wigToBigWig $1 /data/lowelab/RefGenomes/$2/$2.chrom.sizes $3
