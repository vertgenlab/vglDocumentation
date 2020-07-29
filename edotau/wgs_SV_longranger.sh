#!/bin/sh
#SBATCH --mem=96G
#SBATCH --time=3-0
#SBATCH --ntasks=4 --cpus-per-task=4
#SBATCH --exclude=dl-01,x2-02-3
#SBATCH --mail-type=ALL --mail-user=eric.au@duke.edu
DIR=/data/lowelab/edotau/10xGenomics/RABS_688
name=RABS_10x
module add GenomeAnalysisTK/3.7-gcb01
module GenomeAnalysisTK/3.7-gcb01
echo "$SLURM_CPUS_ON_NODE cores on this node"
longranger=/data/lowelab/edotau/bin/github.com/longranger-2.2.2/longranger
ref=/data/lowelab/edotau/toGasAcu1.5/idx/refdata-stickleback_v5_assembly
$longranger wgs \
--vcmode=gatk:/data/lowelab/edotau/toGasAcu1.5/SV_wgs/GenomeAnalysisTK.jar \
--id=$name \
--fastq=$DIR \
--reference=$ref \
--jobmode=slurm \
--localcores=$SLURM_CPUS_ON_NODE \
--localmem=96 \
--maxjobs=500 \
--jobinterval=1000 \
--override=/data/lowelab/edotau/bin/github.com/longranger-2.2.2/martian-cs/2.3.2/jobmanagers/commonOverride.config.json \
--nopreflight
