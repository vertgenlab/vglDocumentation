#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --nodes=1
#SBATCH --parsable
#SBATCH --time=1-00:00:00
BAM=$1
PREFIX=$(basename $BAM .bam)
DIR=$2
markedDups=${PREFIX}.markedDups.bam
module load GATK/4.1.3.0-gcb01
module load samtools java/1.8.0_45-fasrc01
gatk --java-options "-Xmx4G" MarkDuplicates -I $BAM -O $markedDups -M ${PREFIX}".dup.metrics" -VALIDATION_STRINGENCY SILENT -CREATE_INDEX true -ASSUME_SORTED true -REMOVE_DUPLICATES true
samtools index $markedDups
qNameSort=$(basename $markedDups .bam).name.sorted.bam
samtools sort -@ 8 -n -o $qNameSort $markedDups
gatk --java-options "-Xmx4G" FixMateInformation -I $qNameSort -ADD_MATE_CIGAR true -IGNORE_MISSING_MATES true -ASSUME_SORTED true
rm $markedDups ${markedDups}.bai
#q=(0.05 0.01)
#a=(200 300)
peakCaller=/data/lowelab/edotau/sticklebackCipher/bin/Genrich/Genrich
$peakCaller -t $qNameSort -o ${PREFIX}.tmp -j -y -v -D
sort -k1,1 -k2,2n ${PREFIX}.tmp > ${PREFIX}pValue.bed
#https://github.com/jsh58/Genrich
