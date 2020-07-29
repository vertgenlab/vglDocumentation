#!/bin/sh
set -e
query=/data/lowelab/edotau/toGasAcu2RABS/assembly/pacbio_rabs_688/alignToFresh/raw_bams/*.subreads.bam
REF=/data/lowelab/edotau/2.5_RABS.draft/hic/hic2.0_Scaffolds_THREE_Spine/2nd_arrow_polish/THREE_Spine_draft.2.48.fa
for BAM in $query
do

	OUT=$(basename $BAM .subreads.bam).pbalign_248.bam
	sbatch --mem=32G --nodes=1 --ntasks=1 --cpus-per-task=16 --job-name=linkedReads --mail-type=END,FAIL --mail-user=eric.au@duke.edu --exclude=dl-01 --wrap="blasr $BAM $REF --bam --nproc $SLURM_CPUS_ON_NODE --bestn 10 --minMatch 12 --maxMatch 30 --nproc 8 --minSubreadLength 50 --minAlnLength 50 --minPctSimilarity 70 --minPctAccuracy 70 --hitPolicy randombest --randomSeed 1 --placeGapConsistently --advanceExactMatches 10 --out $OUT"
done
exit 0


#--bestn 10 --minMatch 12  --maxMatch 30  --nproc 8  --minSubreadLength 50 --minAlnLength 50  --minPctSimilarity 70 --minPctAccuracy 70 --hitPolicy randombest  --randomSeed 1  --placeGapConsistently --advanceExactMatches 10
