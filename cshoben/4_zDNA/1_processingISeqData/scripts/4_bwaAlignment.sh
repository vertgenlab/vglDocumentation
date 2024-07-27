#!/bin/bash

module load samtools/1.10
/hpc/group/vertgenlab/crs70/software/bwa/bwa-0.7.17/bwa mem \
	-t 10 /hpc/group/vertgenlab/crs70/refGenomes/$1/$1.fa \
	$2 \
	$3 |\
       	samtools sort |\
       	samtools view -S -b > \
	$1$4.mem.sorted.bam
echo "$0  where input was: $1 $2 $3 $4"

##USAGE:
##$1 - ref genome (ie mm10)
##$2 - full path to first fasta (ie /data/lowelab/chelsea/...)
##$3 - full path to second fasta (ie /data/lowelab/chelsea...)
##$4 - fasta description used to label output folder (ie cbrmSRR8119850)
##Use bwa mem to do an alignment, use samtools to sort it, and use samtools to view it and output a SAM file. Run script with the first argument being the reference genome for the alignment (ex: mm10). Have the second argument be the path to the first fasta we are using to align and the third argument be to the second fasta. Have the fourth argument to be a note on the sequence aligned to make a new folder. This code will produce a new file titled "alignOutput$1$4.mem.sorted.sam" in the scripts/alignSeqToGenome/ directory

