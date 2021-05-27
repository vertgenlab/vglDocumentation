#!/bin/csh -ef

set nV = 1000
#set nS = 100

foreach v (*.vcf)
	set prefix = $v:r
	sbatch --mem=128G --wrap="/home/rjm60/go/bin/sampleVcf -randSeed -numVariants $nV $v Sample/$prefix.N1000.vcf"
end

