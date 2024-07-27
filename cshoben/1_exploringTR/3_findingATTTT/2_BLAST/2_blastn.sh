#!/bin/bash

#SBATCH --mem 8G
## See https://bioinformatics.stackexchange.com/questions/4226/blastn-no-hits-found for how I chose some of these parameters

module load NCBI-BLAST/2.7.1

blastn \
	-query /hpc/group/vertgenlab/crs70/projects/1_exploringTR/findingATTTT/fakeATTTT.fa \
	-db hg38_blastdb \
	-word_size 10\
	-evalue 1e-6\
	-dust no\
	-outfmt 6\ ##remove this line to get the non-parsable version
	-out result_6_fakeATTTT_hg38.tsv	


## -output 6 will create a tab separated file with the following. 
## 1. query seq ID
## 2. subject seq ID
## 3. percentage of identical matches
## 4. length of seq overlap
## 5. number of mismatches
## 6. number of gap openings
## 7. start of alignment in query
## 8. end of alignment in query
## 9. start of alignment in subject
## 10. end of alignment in subject
## 11. evalue
## 12. bitscore

## see: https://www.metagenomics.wiki/tools/blast/blastn-output-format-6
