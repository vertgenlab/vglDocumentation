#!/bin/csh -ef

set b = HAQER.filter30.bed

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/sequelOverlap $b $v HAQER/$prefix.HAQER.vcf"
end

echo DONE
