#!/bin/bash
#SBATCH -J
#SBATCH -o %AjoinGenoEstr%A.out
#SBATCH -e %AjoinGenoEstr%A.err


filename='gtexEstrTissues.txt' 
echo Start
while read p; do
	echo "$p"
	join -1 2 -2 2 noSexCountStrHg19HipstrReference.txt "$p"FRCollapseDNA.txt > joinHg19HipstrRef"$p"EstrCounts.txt

done < "$filename"
