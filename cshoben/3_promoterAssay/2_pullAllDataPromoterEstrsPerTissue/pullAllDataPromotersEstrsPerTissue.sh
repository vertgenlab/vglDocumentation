#!/bin/bash
#SBATCH -j

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	awk -F '\t' 'NR==FNR{c[$2]++;next};c[$3]' /hpc/group/vertgenlab/crs70/publicData/eSTRs/15_pullPromotersBedMinDisNameOutput/promoter"$p".bed /hpc/group/vertgenlab/crs70/publicData/eSTRs/raw/master/"$p"_master.tab > sameCoordPromoter"$p".tab 
	awk -F '\t' 'NR==FNR{c[$4]++;next};c[$2]' /hpc/group/vertgenlab/crs70/publicData/eSTRs/15_pullPromotersBedMinDisNameOutput/promoter"$p".bed /hpc/group/vertgenlab/crs70/publicData/eSTRs/16_pullAllDataPromoterEstrsPerTissue/sameCoordPromoter"$p".tab > allDataPromoter"$p".tab

done < "$filename"
