#!/bin/sh
#SBATCH --mem=64G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --nodes=1
#SBATCH --parsable
#Requires name for output folder (prefix), a reference to align to, and a directory for where the 10x fastqs live
name=$1
REF=$2
DIR=$3
longranger=/data/lowelab/edotau/software/longranger-2.2.2/longranger
longranger align --id=$name --reference=$REF --fastqs=$DIR
