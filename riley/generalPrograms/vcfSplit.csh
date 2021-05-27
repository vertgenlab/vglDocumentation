#!/bin/csh -ef

mkdir -p byChrom #output dir
set sizes = /data/lowelab/RefGenomes/hg38/hg38.simple.chrom.list

foreach v (*.vcf)
	set prefix = $v:r
	foreach chr(`cat $sizes`)
		sbatch --wrap="/home/rjm60/go/bin/vcfFilter -chrom $chr $v $prefix.$chr.vcf"
	end
end

echo DONE
