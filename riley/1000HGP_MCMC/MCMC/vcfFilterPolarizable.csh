#!/bin/csh -ef

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/vcfFilter -onlyPolarizableAncestors $v $prefix.polar.vcf"
end

echo DONE
