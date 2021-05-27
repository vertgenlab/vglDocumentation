#!/bin/csh -ef

set sizeFile = /data/lowelab/RefGenomes/hg38/hg38.simple.chrom.sizes
set inFile = HAQER.filter30.bed

foreach c (` cut -f1 $sizeFile`)
	echo $c
	~/go/bin/bedFilter -chrom $c $inFile HAQER_byChrom/$c.$inFile
end

echo DONE
