#!/bin/bash
#SBATCH -J math2Tiss
#SBATCH -o %Amath2Tiss%A.out
#SBATCH -e %Amath2Tiss%A.err
#SBATCH --mem 5G
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL

#Fold change in both directions

awk '{print $1, $2, $3, $4/$5}' \
combineTrimmedTRMm10AtacSRR50SRR42.bed | \
sort -k 4nr \
> sortfoldSRR52SRR42TrMm10.bed

awk '{print $1, $2, $3, $5/$4}' \
combineTrimmedTRMm10AtacSRR50SRR42.bed | \
sort -k 4nr \
> sortfoldSRR52SRR42TrMm10.bed

