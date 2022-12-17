#!/bin/bash
#SBATCH -J bedMaxWigSRR8119850
#SBATCH -n 1
#SBATCH --mem 200G
#SBATCH -o outBedMaxWigGeneric%A_%a.out
#SBATCH -e errBedMaxWigGeneric%A_%a.err

##Usge: $1 is path to the bed file of repeats. $2 is the path to the wig of interest $3 is path to the chrom sizes of interest $4 is the output name
cd /data/lowelab/chelsea/scripts/bedMaxWig/

/home/crs70/go/bin/bedMaxWig $1 $2 $3 $4 
