#!/bin/sh
#!/bin/sh
#SBATCH --mem=64G
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=12
#SBATCH --mail-type=ALL
#SBATCH --mail-user=eric.au@duke.edu
#SBATCH --parsable
#SBATCH --job-name=HicMapFilter
module add samtools perl/5.10.1-fasrc04 java/ GATK
COMBINER='/data/lowelab/edotau/software/mapping_pipeline/two_read_bam_combiner.pl'
PICARD='/data/lowelab/edotau/software/picard.jar'
MAPQ_FILTER=10
BAM1=$1
BAM2=$2
REF=$3
qcBAM=$4
bed=$5
#GFA=$6
FAIDX=$REF.fai
samtools faidx $REF -o $FAIDX
echo "### Step 3A: Pair reads & mapping quality filter"
echo "### Step 3.B: Add read group"
perl $COMBINER $BAM1 $BAM2 samtools $MAPQ_FILTER | samtools view -bS -t $FAIDX - | samtools sort -@ 12 | \
        gatk --java-options "-Xmx50G" AddOrReplaceReadGroups \
        -I /dev/stdin -O /dev/stdout -ID HiC -LB HicArima -SM draft_assembly -PL ILLUMINA -PU GATCGANTC | \
        gatk --java-options "-Xmx50G" MarkDuplicates -I /dev/stdin -O $qcBAM \
        -M /dev/null -AS true --VALIDATION_STRINGENCY LENIENT --REMOVE_DUPLICATES TRUE
samtools index $qcBAM
STATS='/data/lowelab/edotau/software/mapping_pipeline/get_stats.pl'
perl $STATS $qcBAM > $(basename $qcBAM .bam).stats
echo "Finished Mapping Pipeline through Duplicate Removal"
module add bedtools2/2.25.0-fasrc01
echo "Converting bam to bed"

bamToBed -i $qcBAM > $bed
sort -k 4 $bed > tmp && mv tmp $bed
echo "Finished generating bed file for SALSA input"
/data/lowelab/edotau/sticklebackCipher/assembly/salsa_assembly.sh $bed $REF finishedHicAssembly $GFA
