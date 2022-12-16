#!/bin/bash
#SBATCH -J


filename='gtexEstrTissues.txt'
echo Start
while read p; do
	echo "$p"
	echo hipstrGenome
	cat percentTissueOverGenomeEstr"$p".txt | sort -k4 | tail -n 30 > tempTail"$p".txt
	awk -v p=$p '{print $1, $2, $3, $4, $5=p}' tempTail"$p".txt  > tailPercentHipster"$p".txt 

	echo totalEstr
	cat percentTissueOverTotalEstr"$p".txt | sort -k4 | tail -n 30 > tempTailTotal"$p".txt
        awk -v p=$p '{print $1, $2, $3, $4, $5=p}' tempTailTotal"$p".txt  > tailPercentTotal"$p".txt




done < "$filename"


cat tailPercentTotal* > top30PercentageTissuesTotalEstr.txt
cat tailPercentHipster* > top30PercentageTissuesHipstr.txt
