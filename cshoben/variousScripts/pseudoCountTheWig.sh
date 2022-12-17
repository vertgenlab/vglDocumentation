#!/bin/bash
#SBATCH -J pseuCount
#SBATCH -o %ApseuCoun%A.out
#SBATCH -e %ApseuCount%A.err
#SBATCH --mem 8G
#SBATCH -p scavenger
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL

# $1 SRR #
# $2 reference name
# ONLY REQUIRES A WIG FILE INPUT. 
# WIG MUST BE IN SAME LOCATION AS THIS SCRIPT

awk '{if ($0 !~/chr/) print $1+5; else print $0;}' $1$2.wig > $1$2pseCount.wig



