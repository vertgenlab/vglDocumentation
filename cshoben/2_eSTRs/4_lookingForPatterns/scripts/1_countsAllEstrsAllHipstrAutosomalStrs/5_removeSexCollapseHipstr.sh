#!/bin/bash

## Turns out the eSTR raw data does not have any sex chromosomes reported. I do not want to include sex chr in my background if there were never studied. Removing to improve accuracy of my normalization. 

awk '{ if ($1 != "chrX" && $1 != "chrY") print}' hg19.hipstr_reference.bed | cut -f 7 | tr "/" "\n" | sort | uniq -c > noSexCountStrHg19HisptrReference.txt
