#!/bin/bash
#SBATCH --mem 80GB
#SBATCH -p scavenger

diff $1 $2 > $3
