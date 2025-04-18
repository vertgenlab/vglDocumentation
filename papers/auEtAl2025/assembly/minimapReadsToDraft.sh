#!/bin/sh
#SBATCH --mem=32G
#SBATCH --cpus-per-task=12
#SBATCH --ntasks=1
#SBATCH --nodes=1
#SBATCH --parsable
#SBATCH --time=0-8:00:00
set -e
minimap=/data/lowelab/edotau/bin/minimap2-2.17_x64-linux/minimap2
module add samtools
target=$1
query=/data/lowelab/edotau/scratch/sticklebackGenomeProject/trimmedFilteredReads/3Spine.RABS.trimmedReads.fasta
bn=readsTo$(basename $target .fasta)
OUT=$2
$minimap -t $SLURM_CPUS_ON_NODE -ax map-pb $target $query --secondary=no | samtools sort -@ $SLURM_CPUS_ON_NODE -m 1G -o $OUT -T ${bn}.tmp

