#!/bin/bash
#SBATCH -J 
#SBATCH -o %AcaviarTissueCompare%A.out 
#SBATCH -e %AcaviarTissueCompare%A.err

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cd /work/crs70/caviarTissueCompare
	awk 'BEGIN { FS = "\t"} {if ($26 >= 0.3) print $0}' /hpc/group/vertgenlab/crs70/publicData/eSTRs/raw/master/"$p"_master.tab > "$p"TempCaviar_master.txt
	cut -f 9 "$p"TempCaviar_master.txt | grep -v motif > "$p"tempForwardRepeat.txt
	cut -f 10 "$p"TempCaviar_master.txt | grep -v motif > "$p"tempReverseRepeat.txt
	cat "$p"tempForwardRepeat.txt "$p"tempReverseRepeat.txt | sort | uniq -c | sort -k2 > "$p"TempCaviarFRCollapseDNA.txt
	join -1 2 -2 2 /hpc/group/vertgenlab/crs70/publicData/eSTRs/caviarTissueCompare/totalEstrStudied.txt "$p"TempCaviarFRCollapseDNA.txt > tempJoinCaviarHg19EstrTotal"$p"EstrCounts.txt
	awk -v p=$p '{print $1, $2, $3, $3/$2, $5=p}' tempJoinCaviarHg19EstrTotal"$p"EstrCounts.txt > tempFractionTotalEstr"$p".txt 
		
done < "$filename"
echo loopDone
cat tempFractionTotalEstr* > tempAllTissueFractionTotalEstr.txt
cat tempAllTissueFractionTotalEstr.txt | tr " " "\t" | sort -k3 -g > /hpc/group/vertgenlab/crs70/publicData/eSTRs/caviarTissueCompare/allTissueFractionTotalEstr.txt 

echo End
