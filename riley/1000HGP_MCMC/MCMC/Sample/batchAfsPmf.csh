#!/bin/csh -ef

foreach v (*.vcf)
	set prefix = $v:r
	~/go/bin/afsPmf $v $prefix.HighCoverage.AfsPmf.txt
end

echo DONE
