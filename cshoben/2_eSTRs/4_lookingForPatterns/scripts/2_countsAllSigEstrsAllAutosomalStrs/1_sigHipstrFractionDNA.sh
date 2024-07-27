#!/bin/bash
#SBATCH -J 
#SBATCH -o %AfilterFRTR%A.out 
#SBATCH -e %AfilterFRTR%A.err

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	awk '{if ($21 == "True") print $0}' "$p"_master.tab > "$p"Sig_master.txt
	cut -f 9 "$p"Sig_master.txt | grep -v motif > "$p"SigForwardRepeat.txt
	cut -f 10 "$p"Sig_master.txt | grep -v motif > "$p"SigReverseRepeat.txt
	cat "$p"SigForwardRepeat.txt "$p"SigReverseRepeat.txt | sort | uniq -c | sort -k2 > "$p"SigFRCollapseDNA.txt
	join -e -1 2 -2 2 noSexCountStrHg19HisptrReference.txt "$p"SigFRCollapseDNA.txt > joinSigHg19HipstrRef"$p"EstrCounts.txt
	awk '{print $1, $2, $3, $3/$2}' joinSigHg19HipstrRef"$p"EstrCounts.txt > percentTissueOverGenomeEstr"$p".txt 
done < "$filename"
echo End
