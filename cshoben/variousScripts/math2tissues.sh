#!/bin/bash
#SBATCH -J math2Tiss
#SBATCH -o %Amath2Tiss%A.out
#SBATCH -e %Amath2Tiss%A.err
#SBATCH --mem 5G
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL

cut -d$'	' -f 1,2,3,7 $1 > cut$1
