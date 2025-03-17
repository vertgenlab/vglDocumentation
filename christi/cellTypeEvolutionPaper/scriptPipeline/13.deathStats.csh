#!/bin/csh -efv

set atlas=/hpc/group/vertgenlab/riley/20220126_HAQER_SCREEN/singleCellAtacAtlas/PeaksFixed
set dDir=/work/cf189/runPairwiseAlignments/deadNode/hg38
set bDir=/work/cf189/runPairwiseAlignments/birthNode
set coverage=$bDir/coverageCalls.hg38
set speciesNodes=/hpc/group/vertgenlab/christi/vertCons/60way/speciesNodeFiles/hg38.speciesNode.list
set temp=tempDeath.noStats.tsv
set out=allDeathStats.updated.tsv
set db="hg38"

foreach s (`cat species.list`)

if ($s != $db && $s != "petMar3") then

echo $s
cat $dDir/node*.$s.*.bed > $dDir/$s.dead.bed

$GOBIN/bedMerge -keepAllNames $dDir/$s.dead.bed $dDir/$s.dead.merged.bed
endif
end

touch $temp
rm $temp
touch $temp

foreach cellType ($atlas/*.gz)
set name=$cellType:t:r:r

	foreach sN (`cat $speciesNodes`)
	set species=$sN:r:t
	set node=$sN:e:t
	

		if ($species != "petMar3") then
			set sum=0
			set ceiling=`expr $node + 1`
			if ($ceiling == 17) then
			set sum=`grep $name $coverage/node17.bed | wc -l`
			
			else
			foreach i (`seq 17 -1 $ceiling`)
			echo $i
	
			set tmp=`grep $name $coverage/node$i.bed | wc -l` 
			set sum=`expr $sum + $tmp`
			end
			endif

		set dead=`awk -v name="$name" '{if ($4 ~ /name/) count+=1} END {print count}' $dDir/$species.dead.bed`

		echo "$name	$species	$sum	$dead" >> $temp

		endif
	end

end
awk '{answer=$4/$3} {print $0"\t"answer}' $temp > $out

