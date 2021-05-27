#!/bin/csh -ef

mkdir -p ../HAQER_Bed

foreach file (*.Human.HCA.fa)
	set chr=$file:r:r:r
	sbatch --mem=200G --wrap="/home/rjm60/go/bin/faFindFast -chrom $chr -windowSize 500 $file ../HAQER_Bed/$chr.fast500.bed"
end

echo DONE
