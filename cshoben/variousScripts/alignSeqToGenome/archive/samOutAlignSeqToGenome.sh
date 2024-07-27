#!/bin/bash
#SBATCH -J alignSeqToGenome
#SBATCH -n 1
#SBATCH --mem 200G
#SBATCH -o outSamOutAlignToGenome%A_%a.out
#SBATCH -e errSamOutAlignSeqToGenome%A_%a.err

##USAGE: Use bwa mem to do an alignment, use samtools to sort it, and use samtools to view it and output a SAM file. Run script with the first argument being the reference genome for the alignment (ex: mm10). Have the second argument be the path to the first fasta we are using to align and the third argument be to the second fasta. Have the fourth argument to be a note on the sequence aligned to make a new folder. This code will produce a new file titled "alignOutput$1$4.mem.sorted.sam" in the scripts/alignSeqToGenome/ directory

mkdir -p -v /data/lowelab/chelsea/scripts/alignSeqToGenome/samOutSortedAlignOutput$1$4
cd /data/lowelab/chelsea/scripts/alignSeqToGenome/samOutSortedAlignOutput$1$4
module load bwa
module load samtools
bwa mem -t 10 /data/lowelab/RefGenomes/$1/$1.fa $2 $3 | samtools sort | samtools view -b > $1$4.mem.sorted.sam 
echo "$0  where input was: $1, $2, $3, $4 ; folder output is samOutSortedAlignOutput$1$2"
