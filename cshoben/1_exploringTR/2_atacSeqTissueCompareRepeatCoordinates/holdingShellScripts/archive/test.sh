#!/bin/bash
#SBATCH -J test
#SBATCH -e %test%A_%a.err
#SBATCH -o %test%A_%a.out
#SBATCH --mail-user=crs70@duke.edu
#SBATCH --mail-type=ALL



head /data/lowelab/RefGenomes/$1/$2

