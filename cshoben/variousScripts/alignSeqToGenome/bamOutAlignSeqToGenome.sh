#!/bin/bash
#SBATCH -J alignSeqToGenome
#SBATCH -n 1
#SBATCH --mem 100G
#SBATCH -o outbamOutAlignToGenome%A_%a.out
#SBATCH -e errbamOutAlignSeqToGenome%A_%a.err

##USAGE: 
## $1 - full path to ref genome (ie mm10) 
## $2 - full path to first fasta (ie /data/lowelab/chelsea/...) 
## $3 - full path to second fasta (ie /data/lowelab/chelsea...) 
## $4 - fasta description used to label output folder (ie mm10CbrmSRR8119850) 

mkdir -p -v /work/crs70/scripts/alignSeqToGenome/bamOutAlignToGenome$4
cd /work/crs70/scripts/alignSeqToGenome/bamOutAlignToGenome$4/

/hpc/group/vertgenlab/crs70/software/bwa/bwa-0.7.17/bwa mem -t 10 $1 $2 $3 > $4.sam 

module load samtools/1.10
samtools sort $4.sam | samtools view -b > $4.bam
echo "$0  where input was: $1 $2 $3 $4 ; file output /work/crs70/scripts/alignSeqToGenome/bamOutAlignToGenome$4/"
