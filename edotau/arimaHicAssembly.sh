#!/bin/sh

set -e
REF=/data/lowelab/edotau/scratch/sticklebackGenomeProject/pacbioMerged/rabsDraft/rabsDraft.contigs.fasta
cwd=$(pwd)
function bwaFilter {
	module load samtools bwa perl/5.10.1-fasrc04 java/1.8.0_45-fasrc01
	FILTER='/data/lowelab/edotau/software/mapping_pipeline/filter_five_end.pl'
	cp $REF $cwd
	READ=$1
	OUT=$2
	echo "bwa mem -t 12 -B 8 $REF $READ | perl $FILTER | samtools view -@ 12 -b -h - > $OUT"
}

function assembly {
	module add samtools perl/5.10.1-fasrc04 java/
	COMBINER='/data/lowelab/edotau/software/mapping_pipeline/two_read_bam_combiner.pl'
	PICARD='/data/lowelab/edotau/software/picard.jar'
	MAPQ_FILTER=10
	BAM1=$1
	BAM2=$2
	REF=$3
	qcBAM=$4
	FAIDX=$REF.fai
	samtools faidx $REF -o $FAIDX
	echo "### Step 3A: Pair reads & mapping quality filter"
	echo "### Step 3.B: Add read group"
	perl $COMBINER $BAM1 $BAM2 samtools $MAPQ_FILTER | samtools view -bS -t $FAIDX - | samtools sort -@ 12 | \
		java -Xmx32G -jar $PICARD AddOrReplaceReadGroups \
		INPUT=/dev/stdin OUTPUT=/dev/stdout ID=HiC LB=HiC SM=draft_assembly PL=ILLUMINA PU=HiSeqX | \
		java -Xms24G -XX:-UseGCOverheadLimit -Xmx24G -jar $PICARD MarkDuplicates INPUT=/dev/stdin OUTPUT=$qcBAM \
		METRICS_FILE=/dev/null ASSUME_SORTED=TRUE VALIDATION_STRINGENCY=LENIENT REMOVE_DUPLICATES=TRUE
	samtools index $qcBAM
	STATS='/data/lowelab/edotau/software/mapping_pipeline/get_stats.pl'
	perl $STATS $qcBAM > $(basename $qcBAM .bam).stats
	echo "Finished Mapping Pipeline through Duplicate Removal"
	module add bedtools2/2.25.0-fasrc01
	echo "Converting bam to bed"
	bed=$5
	bamToBed -i $qcBAM > $bed
	sort -k 4 $bed > tmp && mv tmp $bed
	echo "Finished generating bed file for SALSA input"
	GFA=$6
	/data/lowelab/edotau/sticklebackCipher/assembly/salsa_assembly.sh $bed $REF finishedHicAssembly $GFA
}
fqOne=$1
PREFIX=$(echo $READ1 | rev | cut -d '_' -f 2- | rev)

READ1=$(sbatch --mem=32G --nodes=1 --ntasks=1 --cpus-per-task=12 --mail-type=END,FAIL --mail-user=eric.au@duke.edu --parsable --job-name=hic_bwa_mapping01 bwaFilter $1 )
