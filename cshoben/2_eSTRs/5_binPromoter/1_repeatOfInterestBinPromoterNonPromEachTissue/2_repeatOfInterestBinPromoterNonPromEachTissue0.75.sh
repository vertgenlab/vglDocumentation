#!/bin/bash
#SBATCH -J
## $1 = repeatOfInterest

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cd /work/crs70/repeatOfInterestBinPromoterNonPromEachTissue/
	echo $p
	cat /hpc/group/vertgenlab/crs70/publicData/eSTRs/findAndReplacedEstrFiles/"$p"FindAndReplacedMaster.tsv | awk 'BEGIN { FS = "\t"} {if ($26 >= 0.75) print $0}' | awk -v r=$1 '{FS="\t"}{if ($9 ==r || $10 ==r) print $1, $3, $8, $2}' | tr " " "\t" > "$p"TempRepeatInterestBinPromNonProm.bed
	
	~/go/bin/compareBedDistanceBasedOnName ./"$p"TempRepeatInterestBinPromNonProm.bed /hpc/group/vertgenlab/crs70/publicData/eSTRs/8_repeatOfInterestBinPromoterNonPromEachTissue/tsvEnsemblMartGeneTssHg19.bed /hpc/group/vertgenlab/crs70/publicData/eSTRs/8_repeatOfInterestBinPromoterNonPromEachTissue/$1_"$p"_0.75CompareOnNameHg19.bed

	cd /hpc/group/vertgenlab/crs70/publicData/eSTRs/8_repeatOfInterestBinPromoterNonPromEachTissue/

	awk '{ if ($5 > 2000) print}' $1_"$p"_0.75CompareOnNameHg19.bed > enhancer$1_"$p"_0.75CompareOnNameHg19.bed
	awk '{ if ($5 <= 2000) print}' $1_"$p"_0.75CompareOnNameHg19.bed > promoter$1_"$p"_0.75CompareOnNameHg19.bed

done < "$filename"
echo loopDone
echo done
