#!/bin/bash

## The input file is a blat.txt file. These contain UCSC blat results of the HAQER0059 500bp region (the region Riley tested) to the file name reference genome (I looked at various sepecied). The bed files can be recreated but the .txt files were copy and pasted by hand from UCSC

input=$(echo $1)
filename=$(echo "${input%.*}")
#remove the .txt at the end of the file

awk 'NR > 2 {print}' $1 | awk '{print $9, $11, $12, "blatHit"NR, $4, $10}' OFS='\t' > $filename.bed
#trim out the lines from the Blat results that make the bed
