#!/bin/csh -ef

set g = /data/lowelab/RefGenomes/1000_Human_Genomes_Project/Phased_VCF/Groups/African_NoSW_Or_Caribbean.group

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --wrap="/home/rjm60/go/bin/vcfFilter -biAllelicOnly -substitutionsOnly -groupFile $g $v AFR/$prefix.AFR.vcf"
end

echo DONE
