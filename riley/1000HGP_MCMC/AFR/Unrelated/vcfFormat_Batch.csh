#!/bin/csh -ef

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/vcfFormat -clearInfo $v NoInfo/$prefix.NoInfo.vcf"
end

echo DONE
