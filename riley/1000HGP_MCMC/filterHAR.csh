#!/bin/csh -ef

set b = /data/lowelab/RefGenomes/hg38/Bed/Pollard.HARs.hg38.trimmed.bed

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/sequelOverlap $b $v HAR/$prefix.HAR.vcf"
end

echo DONE
