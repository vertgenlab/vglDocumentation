#!/bin/csh -ef

set atlas=/hpc/group/vertgenlab/riley/20220126_HAQER_SCREEN/singleCellAtacAtlas/PeaksFixed

touch ../humanAtlas.4colUnique.bed
rm ../humanAtlas.4colUnique.bed
touch ../humanAtlas.4colUnique.bed

foreach f ($atlas/*.gz)
set name=$f:t:r:r

zcat $f | cut -f1-4 | tr " " "\t" | awk -v n="$name" '{print $0".line"NR"."n}' >> ../humanAtlas.4colUnique.bed

end

$GOBIN/bedMerge -keepAllNames ../humanAtlas.4colUnique.bed ../humanAtlas.4colMerged.bed

