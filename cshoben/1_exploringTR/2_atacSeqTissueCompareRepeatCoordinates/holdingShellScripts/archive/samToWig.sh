#!/bin/bash
#SBATCH -J samToWig
#SBATCH -n 2
#SBATCH -N 1
#SBATCH --mem 200GB
#SBATCH -e %AerrSamToWig%A_%a.err
#SBATCH -o %AoutSamToWig%A_%a.out

##USAGE:Use the gonomics samToWig.go file to convert an output sam to a wig file. $1 should be the sam file full path (ie /data/lowelab/chelsea/scripts/...), $2 path to the reference genome chr sizes file (ie /data/lowelab/RefGenomes/mm10/mm10.chrom.sizes), and $3 the output wig file name (ie SRR8119850.wig).  

cd /data/lowelab/chelsea/scripts/samToWig/output/

/home/crs70/go/bin/samToWig $1 $2 $3
echo "samToWig.sh where input was: $1, $2, $3"
 
