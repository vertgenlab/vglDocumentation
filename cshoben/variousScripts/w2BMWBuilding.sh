#!/bin/bash
#SBATCH -J wig2BMW
#SBATCH -o %Awig2BMW%A.out
#SBATCH -e %AWig2BMW%A.err
#SBATCH --mem 80G
#SBATCH -p scavenger
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL

## Use $ head -20 to see all instructions for necessary input. If not including an input variable, must remove all that come after (aka, cant only skip $7 because $8 will become $7).

## $1 is SRR number 
## $2 ref genome shorthand
## $3 full path to reference genome

#CHECK BELOW HERE

## $4 full path to ref.chrom.sizes
## $5 full path to tandemRepeat bed file name (have in same folder as script)

## $6 sex (M/F)
## $7 tissue type
## $8 development or adult? (dev/ad)
## $9 body area 

## Code for downloading based on SRR number
## module load SRA-Toolkit/2.9.6-1
## fastq-dump --split-files --gzip $1
## echo 'fastq-dump done'


### Code for running bwa alignment and output to sam file. Use 1.17
#module load samtools/1.10
#/hpc/group/vertgenlab/crs70/software/bwa/bwa-0.7.17/bwa mem $3 $1_1.fastq.gz $1_2.fastq.gz> $1$2.mem.sam
#samtools sort ./$1$2.mem.sam > $1$2.mem.sorted.sam
#echo "samtools sort done"
##samtools view ./$1$2.mem.sorted.bam > $1$2.mem.sorted.sam
##echo "bwa done"

## MESSED WITH THE ARG VALUES SO UPDATE THEM/DOUBLE CHECK ALL THE CODE BELOW

### Code for creating the wig file.
##/hpc/home/crs70/go/bin/samToWig ./$1$2.mem.sorted.sam $4 $1$2.wig
##echo "samToWig is done where input was: $1 (SRR#) $2 (shorthand ref) $3 (unused) $4 (path to chrom.sizes file)"
#
### Code for generating the bedMaxWig file based on the tandem repeat coordinates input via $4
/hpc/home/crs70/go/bin/bedMaxWig -normalize $5 ./$1$2.wig $4 $1$2BedMaxWigNorm.bed
echo "bedMaxWig is done where input was: $5 $1$2.wig $4 $1$2BedMaxWigNorm.bed"
#
### Code for normalizing the bedMaxWig values, based on total number of wig hits. 
#total=$(awk '{s+=$1}END{print s}' $1$2.wig)
#echo "total wig hits is $total"
#awk -v total=$total '{print $1, $2, $3, $7/total}' $1$2BedMaxWig.bed > $1$2$4$5$6$7$8NormBedMaxWig.bed
#echo "normalizing BMW is complete, input was: $1$2.wig for the total to divide by, and $1$2BedMaxWig.bed for the bed file to be manipulated."
#

