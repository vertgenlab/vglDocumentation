#!/bin/csh -ef

set b = UCE_hg38.bed

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/sequelOverlap $b $v UCE/$prefix.UCE.vcf"
end

echo DONE
