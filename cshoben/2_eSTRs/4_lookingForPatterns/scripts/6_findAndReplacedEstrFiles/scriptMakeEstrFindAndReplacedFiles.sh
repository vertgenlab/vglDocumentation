#!/bin/bash
#SBATCH -J
#SBATCH -o %AfindAndReplace%A.out
#SBATCH -e %AfindAndReplace%A.err

## Goal: to turn all AGAG to AG, etc in the file. Need to simplify the repeats so I can accurating count the number of unique repeat types. 
##remember findAndReplace.go is zero based

filename='gtexEstrTissues.txt'
echo Start
while read p; do
	~/go/bin/findAndReplace -columnNumber=8 /hpc/group/vertgenlab/crs70/publicData/eSTRs/raw/master/"$p"_master.tab findAndReplaceEstrSimplifyRepeatUnits.tsv "$p"FindAndReplacedMasterTemp.tsv
	~/go/bin/findAndReplace -columnNumber=9 "$p"FindAndReplacedMasterTemp.tsv findAndReplaceEstrSimplifyRepeatUnits.tsv "$p"FindAndReplacedMaster.tsv


done < "$filename"
echo End
