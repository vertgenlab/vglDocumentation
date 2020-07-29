#!/bin/sh -e
#SBATCH --mem=32G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --nodes=1
#SBATCH --job-name=toGenotypeVcf
#SBATCH --parsable
BAM=$1
PREFIX=$(basename $BAM .bam)

#Either load modules or assign paths to GATK, samtools, and picard tools
module load GATK/4.1.3.0-gcb01
#Set your reference:
REF=/data/lowelab/edotau/toGasAcu2RABS/gasAcu2RABS/gasAcu2RABS.fasta
#if you want to name your files anything else set these variables

DIR=${PREFIX}"_workToGatk"
mkdir -p $DIR
markedDups=$DIR/${PREFIX}.markedDups.bam
output=$DIR/${PREFIX}.gatk.valid.bam
#final output
gVcf=${PREFIX}.g.vcf.gz

gatk --java-options "-Xmx16G" MarkDuplicates -I $BAM -O $markedDups -M $DIR/${PREFIX}".dup.metrics" -VALIDATION_STRINGENCY SILENT -CREATE_INDEX true
#adds Read group information to bam alignments
#this is how GATK differentiates between your cohort of samples

#required aruguments:
library="WGS"
platform="Illumina"
unit="HiSeqX"
sampleID=$PREFIX

gatk --java-options "-Xmx16G" AddOrReplaceReadGroups -I $markedDups -O /dev/stdout -LB $library -PL $platform -PU $unit -SM $PREFIX | gatk --java-options "-Xmx16G" FixMateInformation -I /dev/stdin -O $output -ADD_MATE_CIGAR true -IGNORE_MISSING_MATES true -TMP_DIR $DIR/"fixmate.tmp"
samtools index $output

#Now run GATK on processed BAM
gatk HaplotypeCaller --java-options "-Xmx32G" \
	-I $output -O $gVcf -R $REF \
	-ERC GVCF --native-pair-hmm-threads 12 \
rm $markedDups ${markedDups}.bai
