#!/bin/csh -evf

set atlas=/hpc/group/vertgenlab/riley/20220126_HAQER_SCREEN/singleCellAtacAtlas/PeaksFixed

foreach n (../nodeData/node*)

set node=$n:t:r
set out=/work/cf189/humanAtlas/nodeData/stats/$node.stats.txt

touch $out
rm $out

echo "Node     Cell Type       Regions" > $out

foreach f ($atlas/*.gz)

set name=$f:t:r:r

set lines=`grep $name $n | wc -l`

echo $node
echo $name
echo $lines

echo "$node	$name	$lines"\ >> $out

end
end

