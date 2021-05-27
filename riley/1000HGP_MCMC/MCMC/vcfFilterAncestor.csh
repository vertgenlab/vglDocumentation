#!/bin/csh -ef

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/vcfFilter -removeNoAncestor $v $prefix.filteredNoAncestor.vcf"
end

echo DONE
