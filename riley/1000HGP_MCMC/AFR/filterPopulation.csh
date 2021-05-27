#!/bin/csh -ef

set g = /data/lowelab/RefGenomes/1000_Human_Genomes_Project/Phased_VCF/Groups/2504.group

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/vcfFilter -groupFile $g $v Unrelated/$prefix.Unrelated.vcf"
end

echo DONE
