#!/bin/csh -ef

set sizes = /data/lowelab/RefGenomes/hg38/hg38.simple.chrom.list

mkdir -p byChrom

foreach v (*.vcf)
	set prefix = $v:r
	foreach chr (`cat $sizes`)
		sbatch --wrap="/home/rjm60/go/bin/vcfFilter -chrom $chr $v byChrom/$prefix.$chr.vcf"
	end
end

echo DONE
