#!/bin/sh
#SBATCH --mem=40G
#SBATCH --nodes=1
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=4
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eric.au@duke.edu
#SBATCH --parsable
#SBATCH --time=0-18
#SBATCH --job-name=HicMapFilter
module add samtools
module add bwa
module add perl/5.10.1-fasrc04
module add java/
COMBINER='/data/lowelab/edotau/sticklebackCipher/assembly/mapping_pipeline/two_read_bam_combiner.pl'
#'/data/lowelab/edotau/software/mapping_pipeline/two_read_bam_combiner.pl'
MAPQ_FILTER=10
BAM1=$1
BAM2=$2
REF=$3

FAIDX=$REF.fai
PREFIX=$4
#GFA=$5
echo "### Step 3A: Pair reads & mapping quality filter"

perl $COMBINER $BAM1 $BAM2 samtools $MAPQ_FILTER | samtools view -@ $SLURM_CPUS_ON_NODE -bS -t $FAIDX - | samtools sort -@ $SLURM_CPUS_ON_NODE -o sorted_${PREFIX}.bam
PICARD='/data/lowelab/edotau/software/picard.jar'

echo "### Step 3.B: Add read group"
java -Xmx64G -Djava.io.tmpdir=temp/ -jar $PICARD AddOrReplaceReadGroups INPUT=sorted_${PREFIX}.bam OUTPUT=sorted1_${PREFIX}.bam ID=HiC_688 LB=HiC_688 SM=rabs688_draft_assembly PL=ILLUMINA PU=none

echo "### Step 4: Mark duplicates"
java -Xms32G -XX:-UseGCOverheadLimit -Xmx32G -jar $PICARD MarkDuplicates INPUT=sorted1_${PREFIX}.bam OUTPUT=${PREFIX}_merge_nodubs.bam METRICS_FILE=${PREFIX}_merge_nodubs_stats.txt TMP_DIR=. ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=LENIENT REMOVE_DUPLICATES=TRUE

samtools index ${PREFIX}_merge_nodubs.bam
STATS='/data/lowelab/edotau/software/mapping_pipeline/get_stats.pl'
perl $STATS ${PREFIX}_merge_nodubs.bam > ${PREFIX}_merge_nodubs.bam.stats
echo "Finished Mapping Pipeline through Duplicate Removal"

module add bedtools2/2.25.0-fasrc01
echo "Converting bam to bed"
bed=${PREFIX}_merge_nodubs.final.bed

bamToBed -i ${PREFIX}_merge_nodubs.bam > ${PREFIX}_merge_nodubs.bed
sort -k 4 ${PREFIX}_merge_nodubs.bed > tmp && mv tmp $bed
echo "Finished generating bed file for SALSA input"

#echo "STARTING salsa pipeline"
#/data/lowelab/edotau/scripts/salsa_assembly.sh $bed $REF ${PREFIX}_hic_correction $GFA
sbatch /data/lowelab/edotau/sticklebackCipher/assembly/salsa_assembly.sh $bed $REF Hi-C_Scaffolds
