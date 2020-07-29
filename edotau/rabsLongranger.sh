#!/bin/sh
#SBATCH --mem=96G
#SBATCH --nodes=1
#SBATCH --ntasks=4 --cpus-per-task=4
#SBATCH --time=2-0
#SBATCH --exclude=dl-01,x2-02-3
DIR=/data/lowelab/edotau/cleanUp/scratch/polishAssembly/longranger/DK632
#/data/lowelab/edotau/RABS.HiCanuScaff10x/scratch/polishAssembly/longranger/RABS_688
name=$1
echo $SLURM_CPUS_ON_NODE
longranger=/data/lowelab/edotau/bin/github.com/longranger-2.2.2/longranger
ref=/data/lowelab/edotau/toGasAcu1.5/idx/refdata-stickleback_v5_assembly
#$longranger mkref $2
$longranger align \
--id=$name \
--fastq=$DIR \
--reference=$ref \
--jobmode=slurm \
--localcores=$SLURM_CPUS_ON_NODE \
--localmem=96 \
--maxjobs=500 \
--jobinterval=1000 \
--disable-ui \
--nopreflight
#sbatch --mem=64G --nodes=1 --ntasks=2 --cpus-per-task=8 --wrap="longranger align --id=$name --reference=$3 --fastqs=$DIR"
#--override=/data/lowelab/edotau/bin/github.com/longranger-2.2.2/martian-cs/2.3.2/jobmanagers/overrideConfig.json \
