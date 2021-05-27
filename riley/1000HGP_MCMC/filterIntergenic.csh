#!/bin/csh -ef

set b = hg38.IntergenicNotEncode.bed

mkdir -p IntergenicNotEncode

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/sequelOverlap $b $v IntergenicNotEncode/$prefix.IntergenicNotEncode.vcf"
end

echo DONE
