#!/bin/csh -ef

foreach b (*.bed)
	set prefix = $b:r
	sbatch --wrap="/home/rjm60/go/bin/bedLiftOverToVcf $b $prefix.vcf"
end

echo DONE
