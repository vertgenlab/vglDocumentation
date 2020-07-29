#!/bin/sh
REF=/data/lowelab/edotau/2.5_RABS.draft/hic/hic2.0_Scaffolds_THREE_Spine/RABS_DRAFT_2.46.fa
quiver -j $SLURM_CPUS_ON_NODE --noEvidenceConsensusCall=nocall --algorithm=arrow $1 -r $REF -o RABS_draft2.4_10xScafHiCanu.fasta -o RABS_draft2.4_10xScafHiCanu.fastq -o variants.gff
