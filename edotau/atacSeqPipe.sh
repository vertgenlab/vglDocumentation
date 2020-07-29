#!/bin/sh
set -e
gVcfMerged=stickleback.cohort

BAMS="basic_alignment"
PEAKS="toPeakCalls"
bigWIGS="visualPeaks"
mkdir -p $BAMS
mkdir -p $PEAKS
bamToQC="bamToQC"
for i in *R1*.{fastq,fq}*.gz
do	
	READ1=$i
	PREFIX=$(echo $READ1 | rev | cut -d '_' -f 2- | rev)
	SUFFIX=$(echo $READ1 | rev | cut -d '_' -f 1,2 | rev)
	READ2=$(echo $READ1 | rev | cut -d '_' -f 2- | rev).$SUFFIX

	fqToBam=$(sbatch ./fqToBam.sh $READ1 $READ2 $BAMS)

	bamToPeaks=$(sbatch --dependency=afterok:$fqToBam ./peakAtac.sh $BAMS/${PREFIX}.bam $PEAKS)
	bamToBigwig=$(sbatch --dependency=afterok:$fqToBam $BAMS/${PREFIX}.bam $bigWIGS)

done
exit 0
