#!/bin/bash
#SBATCH -J 
#SBATCH -o %AoverlapTissue%A.out 
#SBATCH -e %AoverlapTissue%A.err

##plan: pull the CAVIAR >= 0.3 and if $9 or $10 is GT for each tissue. cat all these files into a new file. Sort them. Uniq-c 


filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cd /work/crs70/overlapEstrTissueCompare/
	awk 'BEGIN { FS = "\t"} {if ($26 >= 0.3) print $0}' /hpc/group/vertgenlab/crs70/publicData/eSTRs/findAndReplacedEstrFiles/"$p"FindAndReplacedMaster.tsv > "$p"TempOverlapTissue.txt
	awk 'BEGIN {FS="\t"} {if($9=="GT" || $10=="GT") print}' "$p"TempOverlapTissue.txt >"$p"TempOverlapTissueGT.txt
	awk -v p=$p '{FS+"\t"}{if ($33=p) print}' "$p"TempOverlapTissueGT.txt > "$p"TissueNameTempOverlapGT.txt
		
done < "$filename"
echo loopDone
cat *TissueNameTempOverlapGT.txt  > tempAllTissueGTCaviar.txt
cat tempAllTissueGTCaviar.txt | awk 'BEGIN {FS=" "}{print $1, $2, $3, $8, $9, $33}' > /hpc/group/vertgenlab/crs70/publicData/eSTRs/overlapEstrTissueCompare/overlapTissueGT.txt 
cd /hpc/group/vertgenlab/crs70/publicData/eSTRs/overlapEstrTissueCompare/
cat overlapTissueGT.txt | awk 'BEGIN {FS=" "}{print $1, $3, $4, $5}' | sort -k3 -g | uniq -c | sort -k1 -g > uniqEstrOverlapTissueGt.txt
cat overlapTissueGT.txt | awk 'BEGIN {FS=" "}{print $1, $2, $3, $4, $5}' | sort -k3 -g | uniq -c | sort -k1 -g > uniqComboOverlapTissueGt.txt
echo End
