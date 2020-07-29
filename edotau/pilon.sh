#!/bin/sh
#SBATCH --array=1-22
#SBATCH --mem=40G 
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --job-name=assembly
#SBATCH --exclude=dl-01
module add java/1.8.0_45-fasrc01
echo "SLURM_JOBID: " $SLURM_JOBID
echo "SLURM_ARRAY_TASK_ID: " $SLURM_ARRAY_TASK_ID
echo "SLURM_ARRAY_JOB_ID: " $SLURM_ARRAY_JOB_ID
PARAMS=$(awk -v LP=$SLURM_ARRAY_TASK_ID '$1 == LP' contigs.1.txt)
CONTIG=$(echo $PARAMS | awk '{print $2}')
echo $PARAMS
echo $CONTIG
contigs=$1
bam=$2
java -Xmx32G -jar /data/lowelab/edotau/software/pilon-1.22.jar --genome $contigs --bam $bam --output ${CONTIG}.INDEL_polish --targets $CONTIG --threads $SLURM_CPUS_ON_NODE --fix gaps,indels --changes --verbose
#--vcf --fix gaps,local --changes --threads 8 --mindepth 0.5
