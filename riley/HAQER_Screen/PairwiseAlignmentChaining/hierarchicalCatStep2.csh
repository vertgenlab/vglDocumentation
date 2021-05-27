#!/bin/csh -ef

foreach c (`cat /data/lowelab/RefGenomes/hg38/hg38.chrom.sizes | cut -f1 | grep -v 'fix' | grep -v 'chrUn' | grep -v 'alt' | grep -v 'random' | grep -v 'chrM'`)
	cat $c/*.chain > $c.merge.chain
end

echo DONE
