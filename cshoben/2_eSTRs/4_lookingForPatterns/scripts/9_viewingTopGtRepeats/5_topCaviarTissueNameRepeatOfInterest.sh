#!/bin/bash
#SBATCH -J
## $1 = repeatOfInterest

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cd /work/crs70/topCaviarRepeatOfInterestTissueName/
	cat /hpc/group/vertgenlab/crs70/publicData/eSTRs/findAndReplacedEstrFiles/"$p"FindAndReplacedMaster.tsv | awk 'BEGIN { FS = "\t"} {if ($26 >= 0.3) print $0}' | awk -v r=$1 '{FS="\t"}{if ($9 ==r || $10 ==r) print}' | awk -v p=$p '{FS="\t"}{if ($33=p) print}' > "$p"TempTopCaviarRepeatInterest.txt

done < "$filename"
echo loopDone
cat *TempTopCaviarRepeatInterest.txt | awk 'BEGIN{FS=" "}{print $1, $2, $3, $8, $9, $10, $26, $31, $33}' | sort -k7 > /hpc/group/vertgenlab/crs70/publicData/eSTRs/overlapEstrTissueCompare/$1_topCaviarRepeatofInterestTissueName.txt
echo done
