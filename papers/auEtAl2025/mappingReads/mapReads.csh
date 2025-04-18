#!/bin/csh -ef

set genomeFa = "$1"
set readPrefix = "$2"
set outName = "$3"

set bwa = "/hpc/group/vertgenlab/cl454/src/bwa/bwa-0.7.17/bwa"
set samtools = "/hpc/group/vertgenlab/cl454/src/samtools/samtools-1.13/samtools"

set n = $genomeFa:t:r

if ( -e mappedReads/$n.$outName.sorted.bam ) then
	echo Already did $n $readPrefix
else
	$bwa mem -t 12 $genomeFa reads/"$readPrefix"_1.fastq.gz reads/"$readPrefix"_2.fastq.gz \
	| $samtools view -b - > mappedReads/$n.$readPrefix.bam
	$samtools sort -@ 12 mappedReads/$n.$readPrefix.bam -o mappedReads/$n.$outName.sorted.bam
	rm mappedReads/$n.$readPrefix.bam
endif
echo DONE

