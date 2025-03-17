#!/bin/csh -efv

set atlas=/hpc/group/vertgenlab/riley/20220126_HAQER_SCREEN/singleCellAtacAtlas/PeaksFixed
set workingFile=/work/cf189/runPairwiseAlignments/birthNodes/humanAtlas.4colMerged.bed
set outFile=/work/cf189/humanAtlas/atlasStatsMerged.txt

touch $outFile
rm $outFile
touch $outFile

foreach f ($atlas/*.gz)
set name=$f:t:r:r

set lines=`grep $name $workingFile | wc -l`

echo $name
echo $lines

echo "$name	$lines"\ >> $outFile

end

