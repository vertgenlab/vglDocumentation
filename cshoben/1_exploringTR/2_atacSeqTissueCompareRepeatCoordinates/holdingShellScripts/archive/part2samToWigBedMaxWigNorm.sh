#!/bin/bash
#SBATCH -J p2sraAtacStrTissueCompare
#SBATCH -o p2%AoutSraAtac%A.out
#SBATCH -e p2%AerrSraAtac%A.err
#SBATCH --mem 150G
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL

## Use $ head -20 to see all instructions for necessary input. If not including an input variable, must remove all that come after (aka, cant only skip $7 because $8 will become $7).

## $1 is SRR number 
## $2 is reference genome 
## $3 ref.chrom.sizes
## $4 tandemRepeat bed file name (have in same folder as script)
## $5 sex (M/F)
## $6 tissue type
## $7 development or adult? (dev/ad)
## $8 body area 

## Final output: (6 files), 2 fastq, 1 sam, 1 wig, 1 bedMW, 1 normBMW 

echo "code ran was part1SraDownload... with $1, $2, $3, $4, $5, $6, $7, $8 as input"

## Code for downloading based on SRR number
##module load sratoolkit
##fastq-dump --split-files --gzip $1
##echo 'fastq-dump done'

## Code for decompressing the downloaded files
##gunzip $1_1.fastq.gz
##gunzip $1_2.fastq.gz 
##echo 'gunzips done'

## Code for running bwa alignment and output to sam file.
##module load bwa
##module load samtools
##bwa mem -t 10 /data/lowelab/RefGenomes/$2/$2.fa ./$1_1.fastq ./$1_2.fastq | samtools sort | samtools view > $1$2.mem.sorted.sam
##echo "bwa done and sam made"

## Code for creating the wig file.
/home/crs70/go/bin/samToWig ./$1$2.mem.sorted.sam /data/lowelab/RefGenomes/$2/$3 $1$2.wig
echo "samToWig is done where input was: $1. $2"

## Code for generating the bedMaxWig file based on the tandem repeat coordinates input via $4
/home/crs70/go/bin/bedMaxWig ./$4 ./$1$2.wig /data/lowelab/RefGenomes/$2/$3 $1$2BedMaxWig.bed
echo "bedMaxWig is done where input was: $4 $1$2.wig /data/lowelab/RefGenomes/$2/$3 $1$2BedMaxWig.bed"

## Code for normalizing the bedMaxWig values, based on total number of wig hits. 
total=$(awk '{s+=$1}END{print s}' $1$2.wig)
echo "total wig hits is $total"
awk -v total=$total '{print $1, $2, $3, $7/total}' $1$2BedMaxWig.bed > $1$2$4$5$6$7$8NormBedMaxWig.bed
echo "normalizing BMW is complete, input was: $1$2.wig for the total to divide by, and $1$2BedMaxWig.bed for the bed file to be manipulated."


