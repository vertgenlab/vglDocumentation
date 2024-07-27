#!/bin/bash

## This script grabs all eSTRs that are near the SLC11A1 gene (hg19 coordinates)

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	echo "$p"

cat /hpc/group/vertgenlab/crs70/publicData/eSTRs/raw/master/"$p"_master.tab | awk 'BEGIN {OF"\t"} {OFS="\t"} {if($1=="chr2")print}' | awk 'BEGIN {OF"\t"} {OFS="\t"} {if($3>219244000 && $3<219247500)print}' | awk '{FS="\t"} {OFS="\t"} {print $1, $3, $8, $2, $9, $26}'


done < "$filename"
