#!/bin/bash
#SBATCH -J math2Tiss
#SBATCH -o %Amath2Tiss%A.out
#SBATCH -e %Amath2Tiss%A.err
#SBATCH --mem 5G
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL



awk '{print $1, $2, $3, $4/$5}' > foldSRR52SRR42TrMm10.bed

