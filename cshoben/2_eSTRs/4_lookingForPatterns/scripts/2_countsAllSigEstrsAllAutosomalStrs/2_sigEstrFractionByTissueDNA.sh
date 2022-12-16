#!/bin/bash
#SBATCH -J 
#SBATCH -o %AtissueOverEtr%A.out 
#SBATCH -e %AtissueOverEstr%A.err

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	awk '{if ($21 == "True") print $0}' "$p"_master.tab > "$p"Sig_master.txt
	cut -f 9 "$p"Sig_master.txt | grep -v motif > "$p"SigForwardRepeat.txt
	cut -f 10 "$p"Sig_master.txt | grep -v motif > "$p"SigReverseRepeat.txt
	cat "$p"SigForwardRepeat.txt "$p"SigReverseRepeat.txt | sort | uniq -c | sort -k2 > "$p"SigFRCollapseDNA.txt
	join -1 2 -2 2 totalEstrStudied.txt "$p"SigFRCollapseDNA.txt > joinSigHg19EstrTotal"$p"EstrCounts.txt
	# $3/$2 will divide the sig eSTR count by the genome wide (total) count
	awk '{print $1, $2, $3, $3/$2}' joinSigHg19EstrTotal"$p"EstrCounts.txt > percentTissueOverTotalEstr"$p".txt 
done < "$filename"
echo End
