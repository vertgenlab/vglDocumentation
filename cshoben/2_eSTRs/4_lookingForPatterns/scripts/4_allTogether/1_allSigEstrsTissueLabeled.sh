#!/bin/bash
#SBATCH -J


filename='gtexEstrTissues.txt'
echo Start
while read p; do
	echo "$p"
	echo hipstrGenome
	cat percentTissueOverGenomeEstr"$p".txt | sort -k4 > tempHip"$p".txt
	awk -v p=$p '{print $1, $2, $3, $4, $5=p}' tempHip"$p".txt  > allSigEstrLabeledTissueHipster"$p".txt	

	echo totalEstr
	cat percentTissueOverTotalEstr"$p".txt | sort -k4 > tempTotal"$p".txt
        awk -v p=$p '{print $1, $2, $3, $4, $5=p}' tempTotal"$p".txt  > allSigEstrLabeledTissueTotal"$p".txt


done < "$filename"


cat allSigEstrLabeledTissueTotal* > groupedTotalAllSigEstrLabelTissue.txt
cat allSigEstrLabeledTissueHip* > groupedHipstrAllSigEstrLabelTissue.txt
