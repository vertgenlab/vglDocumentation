#!/bin/bash
#SBATCH -J 

# if not working make sure corresponding work folder exists. 
## for each tissue:
#1. pull all CAVIAR > 0.3
#2. grab forward/reverse sequence and combine into one file
#4  sort the file 

## outside loop:
#5. combine all tissues into one file, uniq -c, and sort on the repeat sequence. 
#6. make a hipstr reference normalized to the number of tissues combined (17). (make sure updated hipstr reference)
#7. join normalized hipstr reference.txt and the all tissue estr sequence counts
#8. divide tissue combined eSTRs and hipstr normalized count for fraction 
#9. sort the file on that new column. (sort -k4 -g)


filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cd /work/crs70/compareMyTopFMEstrHitsToPaperFig2E
	awk 'BEGIN {FS="\t"} {OFS = "\t"} {if ($26 > 0.3) print $0}' /hpc/group/vertgenlab/crs70/publicData/eSTRs/raw/master/"$p"_master.tab > "$p"TempFig2e.txt 
	cut -f 9 "$p"TempFig2e.txt | grep -v motif > "$p"tempForwardRepeat.txt
	cut -f 10 "$p"TempFig2e.txt | grep -v motif > "$p"tempReverseRepeat.txt
	cat "$p"tempForwardRepeat.txt "$p"tempReverseRepeat.txt | sort > "$p"TempFig2eFRCollapseDna.txt

done < "$filename"
echo loopDone

cat *TempFig2eFRCollapseDna.txt | sort | uniq -c | sort -k2 > tempAllFig2eFREstrs.txt

cat /hpc/group/vertgenlab/crs70/publicData/eSTRs/9_compareMyTopFMEstrHitsToPaperFig2E/collapseEditedHg19.hipstr_reference.tsv | awk 'BEGIN {OFS=" "} {print $1*17, $2}' | sort -k2 > tempExpandedEditedHg19HipstrRef.tsv 

join -1 2 -2 2 tempExpandedEditedHg19HipstrRef.tsv tempAllFig2eFREstrs.txt | awk 'BEGIN {OFS="\t"} {if ($3>=3) print $1, $2, $3, $3/$2}' | sort -k4 -g > /hpc/group/vertgenlab/crs70/publicData/eSTRs/9_compareMyTopFMEstrHitsToPaperFig2E/fig2EFractionHipstrExpandedEstrFR.tsv
		

echo End
