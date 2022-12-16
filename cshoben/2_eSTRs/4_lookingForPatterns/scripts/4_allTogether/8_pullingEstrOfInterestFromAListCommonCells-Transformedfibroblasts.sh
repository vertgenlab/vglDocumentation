#!/bin/bash
#SBATCH -J

filename='loopListCells-TransformedfibroblastsEstrSigCaviarCountSigTissuesCount.txt'

echo Start
while read p; do
	
	cat Cells-TransformedfibroblastsSigCaviar_master.txt | awk -v p=$p '{if ($9 == p || $10 == p) print}' > "$p"TempListCommonEstrCells-TransformedfibroblastsSigCaviar_master.txt


##	cat percentTissueOverTotalEstr"$p".txt | sort -k4 > tempTotal"$p".txt
 ##       awk -v p=$p '{print $1, $2, $3, $4, $5=p}' tempTotal"$p".txt  > allSigEstrLabeledTissueTotal"$p".txt

done < "$filename"

cat *TempListCommonEstrCells-TransformedfibroblastsSigCaviar_master.txt > combineListCommonEstrCells-TransformedfibroblastsSigCaviar_master.txt
