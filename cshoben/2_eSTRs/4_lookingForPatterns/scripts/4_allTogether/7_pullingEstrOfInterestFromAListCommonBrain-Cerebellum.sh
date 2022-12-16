#!/bin/bash
#SBATCH -J

filename='loopListBrain-CerebellumEstrSigCaviarCountBrainCountSigTissues.txt'

echo Start
while read p; do
	
	cat Brain-CerebellumSigCaviar_master.txt | awk -v p=$p '{if ($9 == p || $10 == p) print}' > "$p"TempListCommonEstrBrain-CerebellumSigCaviar_master.txt


##	cat percentTissueOverTotalEstr"$p".txt | sort -k4 > tempTotal"$p".txt
 ##       awk -v p=$p '{print $1, $2, $3, $4, $5=p}' tempTotal"$p".txt  > allSigEstrLabeledTissueTotal"$p".txt

done < "$filename"

cat *TempListCommonEstrBrain-CerebellumSigCaviar_master.txt > combineListCommonEstrBrain-CerebellumSigCaviar_master.txt
