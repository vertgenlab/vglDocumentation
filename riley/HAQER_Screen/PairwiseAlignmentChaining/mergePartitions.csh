#!/bin/csh -ef

mkdir -p tempMerge

foreach c (`cat /data/lowelab/RefGenomes/hg38/hg38.chrom.sizes | cut -f1 | grep -v 'fix' | grep -v 'chrUn' | grep -v 'alt' | grep -v 'random' | grep -v 'chrM'`)
	echo Working on $c.
	foreach p (`cat /data/lowelab/RefGenomes/panTro6/panTro6.chrom.sizes | cut -f1`)
		#echo Working on Human: $c. Chimp: $p. 
		chainMergeSort $c/chainingOutput/$p/*.chain > $c/$c.$p.merge.chain
	end
end

echo DONE
