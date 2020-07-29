#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --nodes=1
#SBATCH --parsable
#SBATCH --time=0-11:00:00
set -e
#Set reference:
REF=/data/lowelab/edotau/toGasAcu2RABS/gasAcu2RABS/gasAcu2RABS.fasta
module load bwa samtools/1.9-gcb01
#used by trim_galore
module load cutadapt/2.3-gcb01 python/3.7.4-gcb01 pigz/2.3.4-gcb01

READ1=$1
READ2=$2
#depending on which sequencing facility you use, fastq files might come in different naming conventions: ie read.fastq.gz or read.
#ex. echo CL12w16-3_atac_R1.fastq.gz | rev | cut -d '_' -f 2- | rev > CL12w16-3_atac
PREFIX=$(echo $READ1 | rev | cut -d '_' -f 2- | rev)
####Final output####
DIR=${3%/}
BAM=$DIR/${PREFIX}.bam
fastqDIR="QCedFastqs"
trim_galore=/data/lowelab/edotau/software/TrimGalore-0.6.5/trim_galore
$trim_galore -o $fastqDIR --basename $PREFIX --trim-n --max_n 0 --cores 4 --paired $READ1 $READ2
trim1=$fastqDIR/${PREFIX}_val_1.fq.gz
trim2=$fastqDIR/${PREFIX}_val_2.fq.gz

input1=$fastqDIR/${PREFIX}_R1.fastq.gz
input2=$fastqDIR/${PREFIX}_R2.fastq.gz

#Second Trimming of adaptors:
/data/lowelab/software/bbmap/bbduk.sh \
	in1=$trim1 in2=$trim2 \
	out1=$input1 out2=$input2 \
	minlen=25 qtrim=rl trimq=10 ktrim=r k=25 mink=11 hdist=1 \
	ref=/data/lowelab/software/bbmap/resources/adapters.fa

#clean directory: rm $trim1 $ trim2
#MAPPING
echo -e "["$(date)"]\tAligning and sorting..."
bwa mem -t 8 $REF $1 $2| samtools sort -@ 8 -T $DIR/${PREFIX}.tmp /dev/stdin > $BAM
samtools index $BAM
