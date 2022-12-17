#!/bin/bash
#SBATCH -J intermed10
#SBATCH --mem 150G
#SBATCH -o %AOutInter.out
#SBATCH -e %AErrInter.err
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL

##$1 is the SRR number and $2 reference genome $3 reference.chrom.sizes
## $4 tandem repeat bed file name (have in same folder)

module load bwa
module load samtools
bwa mem -t 10 /data/lowelab/RefGenomes/$2/$2.fa ./$1_1.fastq ./$1_2.fastq | samtools sort | samtools view > $1$2.mem.sorted.sam
echo "bwa done and sam made"


echo "input was: $1, $2, $3, $4"

##/home/crs70/go/bin/samToWig ./$1$2.mem.sorted.sam /data/lowelab/RefGenomes/$2/$3 $1$2mem150.wig
##echo "samToWig.sh is done where input was: $1. $2"



##Usge: $1 is path to the bed file of repeats. $2 is the path to the wig of interest $3 is path to the chrom sizes of interest $4 is the output name

## /home/crs70/go/bin/bedMaxWig ./$4 ./$1$2.wig /data/lowelab/RefGenomes/$2/$3 $1$2BedMaxWig.bed


## $1 will be the wig data, have in same location at this script
## $2 bedMaxWig name, have it be in same location at the script being ran.
## note the header will be lost
## new file created with normalized values

##total=$(awk '{s+=$1}END{print s}' $1$2.wig)
##echo $total

##awk -v total=$total '{print $1, $2, $3, $7/total}' $1$2BedMaxWig.bed > $1$2NormBedMaxWig.bed

