#!/bin/bash


##Goal: make a a bigBed of all eSTRs studied to aid when viewing tracks on UCSC

cat /hpc/group/vertgenlab/crs70/publicData/eSTRs/raw/master/WholeBlood_master.tab | tail -n +2 | awk ' BEGIN {FS="\t"} {OFS="\t"} {print $1, $3, $8, $9}' | sort -k1,1 -k2,2n | uniq  > allUniqEstrsForwardSeq.bed

/hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed allUniqEstrsForwardSeq.bed /hpc/group/vertgenlab/crs70/refGenomes/hg19/hg19.chrom.sizes allUniqEstrsForwardSeq.bb
