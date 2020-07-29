#!/bin/sh
set -e
REF=/data/lowelab/edotau/toGasAcu1.5/idx/stickleback_v5_assembly.fa
BAMS="bamfiles"
toGenotypeVcf="vcfs"

mkdir -p $BAMS
#mkdir -p $QCedBAMS
#mkdir -p $toGenotypeVcf

#bamToQC=#bamToQC"
#gvcfJobs=""
touch submit.txt
rm submit.txt
for i in *R1*.fastq.gz
do	
	READ1=$i
	READ2=$(basename $READ1 _R1.fastq.gz)_R2.fastq.gz
	PREFIX=$(echo $READ1 | rev | cut -d '_' -f 2- | rev)
	outBam=$BAMS/${PREFIX}.Qc.bam
	echo "sbatch $PWD/fqToBam.sh $READ1 $READ2 $REF $BAMS $outBam" >> submit.txt
	sbatch $PWD/fqToBam.sh $READ1 $READ2 $REF $BAMS $outBam

done
exit 0
