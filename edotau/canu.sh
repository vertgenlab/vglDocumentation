#!/bin/sh
#SBATCH --mem=16G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --nodes=1
#SBATCH --parsable
#SBATCH --time=0-03:00:00
canu=/data/lowelab/edotau/software/canu/Linux-amd64/bin/canu
module add java/9-gcb01
module add gnuplot/4.6.4-fasrc02
$canu -p rabs.4.1 \
	-d rabs.4.1 \
	corMhapFilterThreshold=0.0000000002 corMhapOptions="--threshold 0.80 --num-hashes 512 --num-min-matches 3 --ordered-sketch-size 1000 --ordered-kmer-size 14 --min-olap-length 2000 --repeat-idf-scale 50" mhapMemory=60g mhapBlockSize=500 ovlMerDistinct=0.975 \
	corThreads=8 \
	corConcurrency=10 \
	corMhapSensitivity=high \
	useGrid=1 \
	gridEngine=slurm \
	gridOptionsExecutive=--mem=64g \
	genomeSize=550m \
	overlapper=mhap \
	utgReAlign=true \
	-nanopore-raw /data/lowelab/edotau/scratch/nanopore_sequencing/filtered/*.fastq \
	-pacbio-raw /data/lowelab/edotau/data/pacbio_rabs_688/alignToFresh/fastqs/*.fastq.gz
