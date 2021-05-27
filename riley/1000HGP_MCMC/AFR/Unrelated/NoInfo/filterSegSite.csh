#!/bin/csh -ef

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/vcfFilter -segregatingSitesOnly $v SegSite/$prefix.segSite.vcf"
end

echo DONE
