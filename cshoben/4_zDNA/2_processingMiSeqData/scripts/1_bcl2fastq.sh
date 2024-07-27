#!/bin/bash
#SBATCH --mem 10G

# script was originally ran on HARDAC

module load bcl2fastq/2.20

bcl2fastq --create-fastq-for-index-reads \
--minimum-trimmed-read-length=8 \
# ignore reads <8
--mask-short-adapter-reads=8 \
--ignore-missing-positions \
--ignore-missing-controls \
--ignore-missing-filter \
-R /work/crs70/20211213_cutAndRun_iSeq_crs_zDna/ \
# -R: directory of sequencing data (hierarchy pulled from sequencer)
-o /work/crs70/processingISeqData/ \
# -o: output 
--sample-sheet=/work/crs70/20211213_cutAndRun_iSeq_crs_zDna/SampleSheet.csv
