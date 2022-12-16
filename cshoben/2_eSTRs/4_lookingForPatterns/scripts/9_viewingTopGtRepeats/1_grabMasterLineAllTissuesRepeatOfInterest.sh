#!/bin/bash
#SBATCH -J
## $1 = chr
## $2 = startOfEstrCoordinates


filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cd /work/crs70/grabMasterLineAllTissuesRepeatOfInterest/
	awk -v c=$1 -v s=$2 'BEGIN { FS = "\t"} {if ($1 == c && $3 == s && $26 >= 0.3) print $0}' /hpc/group/vertgenlab/crs70/publicData/eSTRs/findAndReplacedEstrFiles/"$p"FindAndReplacedMaster.tsv > "$p"TempGrabMasterLine.txt
	awk -v p=$p '{FS+"\t"}{if ($33=p) print}' "$p"TempGrabMasterLine.txt > "$p"TempGrabMasterLineTissueLabeled.txt

done < "$filename"
echo loopDone
cat *TempGrabMasterLineTissueLabeled.txt  > /hpc/group/vertgenlab/crs70/publicData/eSTRs/overlapEstrTissueCompare/$1_$2grabMasterLineAllTissues.txt
echo done
