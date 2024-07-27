#!/bin/bash
#SBATCH -o %AfixBusErr%A.out
#SBATCH -e %AfixBusError%A.err
#SBATCH --mem 80G
#SBATCH -p scavenger
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL

## $1 is SRR number
## $2 ref genome shorthand (eg. mm10)
## $3 full path to reference genome

## Code for downloading based on SRR number
#module load SRA-Toolkit/2.9.6-1
#fastq-dump --split-files --gzip $1
#echo 'fastq-dump done'

# Code for decompressing the downloaded files, leaves a .gz copy since the .fastq will be deleted later.
#gunzip -c $1_1.fastq.gz > $1_1.fastq
#gunzip -c $1_2.fastq.gz > $1_2.fastq
##echo 'gunzips done'

### Code for running bwa alignment and output to sam file.
module load BWA/0.7.17
module load samtools/1.12-rhel8
bwa mem $3 $1_1.fastq.gz $1_2.fastq.gz > $1$2.mem.sam
##samtools sort ./$1$2.mem.sam > $1$2.mem.sorted.sam
##samtools view ./$1$2.mem.sorted.bam > $1$2.mem.sorted.sam
echo "bwa done"

##rm -f $1_1.fastq
##rm -f $1_2.fastq
##echo "deleted the uncompressed fastqs"

