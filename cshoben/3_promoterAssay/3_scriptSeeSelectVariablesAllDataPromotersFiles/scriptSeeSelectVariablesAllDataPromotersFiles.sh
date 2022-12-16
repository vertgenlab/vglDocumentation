#!/bin/bash
#SBATCH -J=grabInfoPromoters

### $1 is the awk file you'd like to use to fileter the promoter files. This script will perform this for all tissues and file slurm out file will contain all the info. 

echo $1
filename='gtexEstrTissues.txt'
echo Start
while read p; do
	echo "$p"
	awk -f $1 /hpc/group/vertgenlab/crs70/publicData/eSTRs/16_pullAllDataPromoterEstrsPerTissue/allDataPromoter"$p".tab

done < "$filename"
