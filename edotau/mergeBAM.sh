#!/bin/sh

set -e
module add samtools
OUT=$1
samtools merge -@ $SLURM_CPUS_ON_NODE - *.pbalign_DRAFT.bam | samtools sort -@ $SLURM_CPUS_ON_NODE > $OUT
pbindex $OUT & samtools index -@ $SLURM_CPUS_ON_NODE $OUT
REF=/data/lowelab/edotau/2.5_RABS.draft/hic/hic2.0_Scaffolds_THREE_Spine/RABS_DRAFT_2.46.fa
quiver -j $SLURM_CPUS_ON_NODE --noEvidenceConsensusCall=nocall --algorithm=arrow $OUT -r $REF -o RABS_draft2.4_10xScafHiCanu.fasta -o RABS_draft2.4_10xScafHiCanu.fastq -o variants.gff
