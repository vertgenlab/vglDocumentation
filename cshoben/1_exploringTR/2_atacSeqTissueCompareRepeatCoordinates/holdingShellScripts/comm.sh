#!/bin/bash
#SBATCH --mem 10GB
#SBATCH -p scavenger

comm -3 $1 $2 > $3
