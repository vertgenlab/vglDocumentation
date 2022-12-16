#!/bin/bash

cat hg19HipsterReference.bed | sort -k 4 > sortedSeqHg19HipstrReference.bed


# Not sure how the hipstrPromoterSequalOverlapOutput.bed file was sorted before being used in the code below. 

cat sortHipstrPromoterSequelOverlapOutput.bed | cut -f 4 | tr "/" "\n" | sort | uniq -c > seqCountSortHipstrPromoterSequelOverlapOutput.txt
