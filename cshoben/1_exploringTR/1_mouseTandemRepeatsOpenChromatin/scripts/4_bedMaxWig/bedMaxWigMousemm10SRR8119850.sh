#!/bin/bash
#SBATCH -J bedMaxWigSRR8119850
#SBATCH -n 1
#SBATCH --mem 200G
#SBATCH -o outBedMaxWigSRR8119850%A_%a.out
#SBATCH -e errBedMaxWigSRR8119850%A_%a.err

cd /data/lowelab/chelsea/scripts/bedMaxWig/

/home/crs70/go/bin/bedMaxWig /data/lowelab/chelsea/MouseTandemRepeats/mouseSimpleRepeatsGenomeBrowser_mm10.bed /data/lowelab/chelsea/scripts/samToWig/output/SRR8119850.wig /data/lowelab/RefGenomes/mm10/mm10.chrom.sizes bedMaxWigSimpleRepeats_mm10_SRR8119850.bed
