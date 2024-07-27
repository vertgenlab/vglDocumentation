#!/bin/bash
#SBATCH -j

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cat /hpc/group/vertgenlab/crs70/publicData/eSTRs/12_runningBedMinimumDistanceName/"$p"RunningBedMinimumDistanceOutput.bed | awk 'BEGIN {FS="\t"} {OFS = "\t"} {if ($5 <= 2000) print $0}'>promoter"$p".bed

done < "$filename"
