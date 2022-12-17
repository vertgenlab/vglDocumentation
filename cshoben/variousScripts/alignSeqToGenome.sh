#!/bin/bash
#SBATCH -J alignSeqToGenome
#SBATCH -n 1
#SBATCH --mem 128G
#SBATCH -e errAlignSeqToGenome.err

##USAGE: Use bwa mem to do an alignment. Run script with the first argument being the reference genome for the alignment (ex: mm10). Have the second argument be the path to the first fasta we are using to align and the third argument be to the second fasta. Have the fourth argument to be a note on the sequenced aligned to make a new folder. This code will produce a new file titled the alignOutput$1$4 in the scripts/alignSeqToGenome/ directory

mkdir -p -v /data/lowelab/chelsea/scripts/alignSeqToGenome/alignOutput$1$4
cd /data/lowelab/chelsea/scripts/alignSeqToGenome/alignOutput$1$4
module load bwa
module load samtools
bwa mem -t 10 /data/lowelab/RefGenomes/$1/$1.fa $2 $3 | samtools view -b > $1$4.bam
echo "alignSeqToGenome.sh where input was: $1, $2, $3, $4"
