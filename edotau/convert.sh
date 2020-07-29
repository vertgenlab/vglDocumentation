#!/bin/bash
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --ntasks=5
#SBATCH --mem=40G
module load coreutils/8.25-gcb01
module load java/1.8.0_45-fasrc01
#bash /data/lowelab/edotau/bin/etc/profile.d/conda.sh
#conda activate python2
JUICER_JAR=/data/lowelab/edotau/software/juicer/scripts/common/juicer_tools_1.12.03.jar
SALSA_OUT_DIR=$1
SCRIPT_PATH=$BASH_SOURCE
SCRIPT_PATH=`dirname $SCRIPT_PATH`

samtools faidx ${SALSA_OUT_DIR}/scaffolds_FINAL.fasta

cut -f 1,2 ${SALSA_OUT_DIR}/scaffolds_FINAL.fasta.fai > ${SALSA_OUT_DIR}/chromosome_sizes.tsv

python ${SCRIPT_PATH}/alignments2txt.py -b ${SALSA_OUT_DIR}/alignment_iteration_1.bed  -a ${SALSA_OUT_DIR}/scaffolds_FINAL.agp -l ${SALSA_OUT_DIR}/scaffold_length_iteration_1 > ${SALSA_OUT_DIR}/alignments.txt

awk '{if ($2 > $6) {print $1"\t"$6"\t"$7"\t"$8"\t"$5"\t"$2"\t"$3"\t"$4} else {print}}' ${SALSA_OUT_DIR}/alignments.txt | sort -k2,2d -k6,6d -T $PWD --parallel=$SLURM_CPUS_ON_NODE | awk 'NF'  > ${SALSA_OUT_DIR}/alignments_sorted.txt

java -jar ${JUICER_JAR} pre ${SALSA_OUT_DIR}/alignments_sorted.txt ${SALSA_OUT_DIR}/salsa_scaffolds.hic ${SALSA_OUT_DIR}/chromosome_sizes.tsv


