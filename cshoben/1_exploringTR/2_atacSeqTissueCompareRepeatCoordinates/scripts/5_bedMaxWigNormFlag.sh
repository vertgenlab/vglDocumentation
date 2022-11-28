#!/bin/bash
#SBATCH --mem 80G

/hpc/home/crs70/go/bin/bedMaxWig -normalize \
mm10StrUcscGBrowser.bed \
SRR8119850mm10pseCount.wig \
/hpc/group/vertgenlab/crs70/refGenomes/mm10/mm10.chrom.sizes \
SRR8119850mm10pseCount_bedMaxWigNorm.bed
