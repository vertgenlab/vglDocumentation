#!/bin/bash

#make bed file
cat ensemblHg19GeneStarts.tsv | awk ' BEGIN {FS="\t"} {OFS ="\t"} {if ($4 == "-1") $4="-"; else if ($4=="1") $4="+"; print "chr"$1, $2-1, $2, $3, 0, $4}' > ensemblHg19GeneStarts.bed 

sed -i '1d' ensemblHg19GeneStarts.bed

#remove all chromsomes not autosomal or sex chr
cat ensemblHg19GeneStarts.bed | grep -v "GL000" | grep -v "CTG" | grep -v "HG" | grep -v "HSCHR" | grep -v "MT" | sort -k1,1 -k2,2n > ensemblHg19GeneStartsIrregChrRemSorted.bed

#make into a bigBed
/hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed ensemblHg19GeneStartsIrregChrRemSorted.bed /hpc/group/vertgenlab/crs70/refGenomes/hg19/hg19.chrom.sizes ensemblHg19GeneStartsIrregChrRemSorted.bb

