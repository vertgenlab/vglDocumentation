#!/bin/csh -ef

set b = /data/lowelab/RefGenomes/hg38/Bed/encodeCcreCombined.short.bed

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/sequelOverlap $b $v ENCODE/$prefix.ENCODE.vcf"
end

echo DONE
