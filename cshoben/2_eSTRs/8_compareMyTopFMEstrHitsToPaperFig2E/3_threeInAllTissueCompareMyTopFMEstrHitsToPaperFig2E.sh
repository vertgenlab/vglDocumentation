#!/bin/bash
#SBATCH -J 

## noteToSelf: Abandoning. I realize that I am collapsing all the counts for a given tissue when I check that it exists at least three times. Line 28. I am unsure how this could possibly be the solution but leaving this file until I know for sure. 

# Goal was to count number in a tissue. Make sure it appears in that tissue at least three times. And then if yes, add that eSTR count from that tissue to the total count. 

# if not working make sure corresponding work folder exists. 
## for each tissue:
#1. pull all CAVIAR > 0.3
#2. grab only forward sequence (that's all that is used for Fig 2e).
#4  sort and unique the file. 

### At this point I will not be calculating the enrichment values, but if I get the same
### order of 
#5. join that and the corresponding hipstr reference.txt (make sure this is the updated hipster file)
#6. do some match across the columns. 
#7. replace the spaces with tabs. 
#8. sort the file on that new column. (sort -k3 -g)


filename='gtexEstrTissues.txt'
echo Start
while read p; do
	cd /work/crs70/compareMyTopFMEstrHitsToPaperFig2E
	awk 'BEGIN {OFS = "\t"} {if ($26 > 0.3) print $0}' /hpc/group/vertgenlab/crs70/publicData/eSTRs/raw/master/"$p"_master.tab > "$p"TempFig2e.txt 
	cut -f 9 "$p"TempFig2e.txt | grep -v motif > "$p"tempForwardRepeat.txt
	cut -f 10 "$p"TempFig2e.txt | grep -v motif > "$p"tempReverseRepeat.txt
	cat "$p"tempForwardRepeat.txt "$p"tempReverseRepeat.txt | sort | uniq -c > "$p"TempFig2eFRDna.txt
	cat "$p"TempFig2eFRDna.txt | awk 'BEGIN {OFS = "\t"} {if($1>=3) print $0}' | sed 's/^ *//g' | tr " " "\t" | cut -f2  > "$p"TempFig2eFRAtLeastThreeDna.txt

done < "$filename"
echo loopDone

cat *TempFig2eFRAtLeastThreeDna.txt | sort > tempSortedAllTissuesCombined.txt 

#uniq -c | sort -k2 > tempAllFig2eFRThreeEstrs.txt

#cat /hpc/group/vertgenlab/crs70/publicData/eSTRs/9_compareMyTopFMEstrHitsToPaperFig2E/collapseEditedHg19.hipstr_reference.tsv | awk 'BEGIN {OFS=" "} {print $1*17, $2}' | sort -k2 > tempExpandedEditedHg19HipstrRef.tsv 

#join -1 2 -2 2 tempExpandedEditedHg19HipstrRef.tsv tempAllFig2eFRThreeEstrs.txt | awk 'BEGIN {OFS="\t"} {if ($3>=3) print $1, $2, $3, $3/$2}' | sort -k4 -g > /hpc/group/vertgenlab/crs70/publicData/eSTRs/9_compareMyTopFMEstrHitsToPaperFig2E/fig2EFractionHipstrExpandedEstrFRThree.tsv
		

echo End
