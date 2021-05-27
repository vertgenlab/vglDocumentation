#!/bin/csh -ef

mkdir -p ../rawFa

foreach file (*.maf)
	set prefix=$file:r
	echo $prefix
	sbatch --mem=200G --wrap="/home/rjm60/go/bin/mafToFa -noMask $file /data/lowelab/RefGenomes/hg38/hg38_chrom/$prefix.fa species.lst ../rawFa/$prefix.fa"
end

echo DONE
