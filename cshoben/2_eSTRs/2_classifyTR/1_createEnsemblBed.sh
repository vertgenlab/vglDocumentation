#!/bin/bash

# remove the strand column, we actually don't need it. 
awk '{print $1, $2, $3}' ensembl_mart_export_hg19.txt > 1ensembl_mart_export_hg19.txt 

# add chr to all the chromosome names
sed -e 's/^/chr/' 1ensembl_mart_export_hg19.txt > 2ensembl_mart_export_hg19.bed

# remove the header, this is not needed in a bed
sed -i '1d' 2ensembl_mart_export_hg19.bed

# add a chrom end value (TSS+1) and make tab separated
awk 'BEGIN{OFS="\t";}{print $1, $2, ($2+1), $3, $4}' 2ensembl_mart_export_hg19.bed > tsvEnsemblMartGeneTSSHg19.bed


# notes: originally included the strand with the bed but later removed it as we don't need that data for our goal. 
