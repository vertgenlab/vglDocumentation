#!/bin/bash
#SBATCH -J wig2BMW
#SBATCH -o %Awig2BMW%A.out
#SBATCH -e %Awig2BMW%A.err
#SBATCH --mem 60G
#SBATCH -p scavenger
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL

##Usege: $1 is path to the bed file of repeats. $2 is the path to the wig of interest $3 is path to the chrom sizes of interest $4 is the output name
cd /data/lowelab/chelsea/scripts/bedMaxWig/

/hpc/home/crs70/go/bin/bedMaxWig $1 $2 $3 $4 

