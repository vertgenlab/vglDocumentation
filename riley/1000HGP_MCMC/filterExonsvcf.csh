#!/bin/csh -ef

set b = /data/lowelab/RefGenomes/hg38/Bed/hg38.knownExons.Merged.fromGtf.bed

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/sequelOverlap $b $v Exon/$prefix.Exon.vcf"
end

echo DONE
