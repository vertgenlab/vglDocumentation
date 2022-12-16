#!/bin/bash
#SBATCH -J 
#SBATCH -o %AcavTissueCompareFR%A.out 
#SBATCH -e %AcavTissueCompareFR%A.err

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cd /work/crs70/caviarTissueCompare

## pull out top caviar 
	awk 'BEGIN {FS="\t"} {OFS="\t"} {if ($26 >= 0.3) print $0}' /hpc/group/vertgenlab/crs70/publicData/eSTRs/findAndReplacedEstrFiles/"$p"FindAndReplacedMaster.tsv > "$p"TempCaviar_master.tsv

## cut out forward, reverse seq, combine into one file, sort, and count unique number of each, then sort on the DNA sequence
	cut -f 9 "$p"TempCaviar_master.txt | grep -v motif > "$p"tempForwardRepeat.txt
	cut -f 10 "$p"TempCaviar_master.txt | grep -v motif > "$p"tempReverseRepeat.txt
	cat "$p"tempForwardRepeat.txt "$p"tempReverseRepeat.txt | sort | uniq -c | sort -k2 > "$p"TempCaviarFRCollapseDNA.txt

## put together these counts with the counts from the hipter reference genome into on file 
	join -1 2 -2 2 /hpc/group/vertgenlab/crs70/publicData/eSTRs/caviarTissueCompare/collapseEditedHg19.hipstr_reference.txt "$p"TempCaviarFRCollapseDNA.txt > tempJoinCaviarHg19Hipstr"$p"EstrCounts.txt

## new file determine what percentage genome wide eSTR count for a given sequence come up as top caivar score (column 4). Label the tissue we are looked at. 
	awk -v p=$p '{print $1, $2, $3, $3/$2, $5=p}' tempJoinCaviarHg19Hipstr"$p"EstrCounts.txt > tempFractionHipstr"$p".txt 
		
done < "$filename"
echo loopDone

cat tempFractionHipstr* > tempAllTissueFractionHipstr.txt
cat tempAllTissueFractionHipstr.txt | tr " " "\t" | sort -k3 -g > /hpc/group/vertgenlab/crs70/publicData/eSTRs/caviarTissueCompare/allTissueFractionHipstrFindReplace.txt 

echo End
