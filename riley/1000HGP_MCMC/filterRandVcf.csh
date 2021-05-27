#!/bin/csh -ef

set b = hg38.Rand_1mb.bed

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/sequelOverlap $b $v Simulated/$prefix.Rand.vcf"
end

echo DONE
