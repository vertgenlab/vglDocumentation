#!/bin/sh
set -e

fixToRecalb=/data/lowelab/edotau/sticklebackCipher/gatk/fixBamToRecal.sh

bamToGvcf=/data/lowelab/edotau/sticklebackCipher/gatk/baseRecalibration.sh
dirQC=workToGatk
bamRecal=""
for i in *.bam
do
	PREFIX=$(basename $i .bam)
	bamQC=$(sbatch $fixToRecalb $i)
	bamRecal+=$(sbatch --dependency=afterok:$bamQC $bamToGvcf $dirQC/${PREFIX}.gatk.valid.bam)","
done
jobIDs=$(echo $bamRecal | rev | cut -c 2- | rev)
calbGvcf=recalGenotypeVcfs
mergedGVcf=$(sbatch --dependency=afterok:$jobIDs /data/lowelab/edotau/sticklebackCipher/gatk/combineGVCF.sh MataLitc $calbGvcf)
sbatch --dependency=afterok:$mergedGVcf /data/lowelab/edotau/sticklebackCipher/gatk/getSNPS.sh $calbGvcf/${PREFIX}.cohort.GENOTYPED.vcf.gz
sbatch --dependency=afterok:$mergedGVcf /data/lowelab/edotau/sticklebackCipher/gatk/getIndels.sh $calbGvcf/${PREFIX}.cohort.GENOTYPED.vcf.gz
exit 0
