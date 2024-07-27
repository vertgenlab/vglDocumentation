#!/bin/bash

##input my eSTRs of interest (will include all the columns)
##turn it into a bed (use code from my methods section)
##need my bed for all the genes too --> just place it in this folder. 
##then run my gonomics program using these files and output could be distanceInputBed
##then I will want to look at this file and do some awk math. 
		##if this new column is 2000 upstream of TSS or 200 downstream --> save and call file promoterDistanceInputBed
		##		I think the output will just be a number without directionality. 
		##if this new column is NOT (2000 upstream of TSS or 200 downstream --> save and call file enhancerDistanceInputBed
filename='gtexEstrTissues.txt'
echo Start
while read p; do

cd /hpc/group/vertgenlab/crs70/publicData/eSTRs/raw/master/
cat "$p"_master.tab | awk ' BEGIN { FS = "\t"} {if ($26 > 0.3) print $1, $3, $8, $2}' | tail -n +2 | tr " " "\t" > /work/crs70/geneRegLabelingOfEstrs/tsv"$p"Temp.bed

cd /hpc/group/vertgenlab/crs70/publicData/eSTRs/geneRegLabelingOfEstrs/
~/go/bin/compareBedDistanceBasedOnName /work/crs70/geneRegLabelingOfEstrs/tsv"$p"Temp.bed ./tsvEnsemblMartGeneTssHg19.bed ./compareOnName"$p"Hg19.bed 

awk '{ if ($5 > 2000) print}' ./compareOnName"$p"Hg19.bed > enhancerCompareOnNameTestRemEq"$p"Hg19.bed
awk '{ if ($5 <= 2000) print}' ./compareOnName"$p"Hg19.bed > promoterCompareOnNameTestRemEq"$p"Hg19.bed

done < "$filename"
echo End


