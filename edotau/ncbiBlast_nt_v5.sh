#!/bin/sh
#SBATCH --mem=32G
#SBATCH --cpus-per-task=1 --ntasks=12
#SBATCH --nodes=1
#SBATCH --mail-type=FAIL --mail-user=eric.au@duke.edu
#SBATCH --job-name=BLASTqc
set -e
#Takes query fasta file and name of text file for output blast results
QUERY=$1
OUT=$2
module add glibc/2.14-gcb01
dataBase=/data/lowelab/edotau/software/ncbi-blast-2.10.0+/ncbiDB/nt_v5
nBLAST=/data/lowelab/edotau/software/ncbi-blast-2.10.0+/bin/blastn

$nBLAST -query $QUERY -db $dataBase -evalue 1e-10 -max_target_seqs 2 -max_hsps 1 -num_threads $SLURM_CPUS_ON_NODE -perc_identity 85 -out $OUT -outfmt "6 qseqid qlen sseqid length score evalue pident nident mismatch"
