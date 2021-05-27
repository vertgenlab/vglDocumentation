#!/bin/csh -ef

set b = ndHAQER.bed

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/vcfOverlap $v $b $prefix.ndHAQER.vcf"
end

echo DONE
