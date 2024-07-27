#!/bin/bash
#SBATCH -J maxWig
#SBATCH --mem 10GB
#SBATCH -e %AmaxWigValue%A.err
#SBATCH -o %AaxWigValue%A.out


cat $1 | sort -n > sorted.$1
