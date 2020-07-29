#!/bin/sh -e
atacPipe=/data/lowelab/edotau/sticklebackCipher/atac/fqToAtacPeaks.sh
for i in *R1.fastq.gz
do
	sbatch $atacPipe $i $(basename $READ1 R1.fastq.gz)R2.fastq.gz
done
exit 0
