#!/bin/csh -efv
#adding a column with the birth node label
foreach f (/work/cf189/runPairwiseAlignments/birthNode/coverageCalls.hg38/node*.bed)
set prefix=$f:r
set node=$f:t:r

echo $node

awk -v node="$node" '{print $0"\t"node}' $f > $prefix.labeled.bed
end


set ref="hg38"
set workingDir=/work/cf189/runPairwiseAlignments/deadNode/$ref
set i=17
set nodeFile=birthNode/coverageCalls.$ref/node$i.labeled.bed
set alignmentDir=/work/cf189/runPairwiseAlignments/60way/$ref.wholeGenomeAlignments
set intervalOverlap=$GOBIN/intervalOverlap

foreach i (`seq 17 -1 0`)

foreach sN (`cat birthNode/$ref.speciesNode.list`)

set species=$sN:r

if ("$species" == "$ref") then
continue
else

set node=$sN:e

if ($node < $i) then

echo "node: "$node
echo "i: "$i

$intervalOverlap -nonOverlap $alignmentDir/$ref.$species.bed $nodeFile deadNode/specific/node$i.$sN.dead.nonOverlap.bed

else
continue

endif
endif
end
end

#adding a label column with the death node
foreach f ($workingDir/node*.*.*.dead.nonOverlap.bed)

set death=$f:t:r:r:r:e
set deathNode="node"$death
set species=$f:t:r:r:r:r:e
set prefix=$f:r:r

echo $death
echo $species

echo $prefix

awk -v death="$deathNode" -v species="$species" '{print $0"\t"death"\t"species}' $f > $prefix.allLabels.bed
end

