#!/bin/bash

#add chr to all the chromosomes
sed -e 's/^/chr/' hg19GeneStableIdGeneStartEndMart_export.txt > hg19ChrGeneStableIdGeneStartEndMart_export.tsv

#remove the header
sed -i '1d' hg19ChrGeneStableIdGeneStartEndMart_export.tsv

#rename it to a bed file
cp hg19ChrGeneStableIdGeneStartEndMart_export.tsv tsvHg19GeneStableIdGeneStartEndMart_export.bed

## TODO need to finish by running through gonomics/cmd/compareBedDistanceBasedOnName and classify the eSTR as being inside a gene if the output distance from the genes is zero. Could do +/- 5bp for wiggle room. 
