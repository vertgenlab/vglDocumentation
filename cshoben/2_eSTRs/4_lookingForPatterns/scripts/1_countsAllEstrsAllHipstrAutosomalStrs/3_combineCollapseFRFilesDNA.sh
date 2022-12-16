#!/bin/bash
#SBATCH -J
#SBATCH -o %AcombineFRDNA%A.out
#SBATCH -e %AcombineFRDNA%A.err

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cat "$p"ForwardRepeat.txt "$p"ReverseRepeat.txt | sort | uniq -c | sort -k2 > "$p"FRCollapseDNA.txt

done < "$filename"

