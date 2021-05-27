#!/bin/csh -ef

set panTro6NoGap = /data/lowelab/RefGenomes/panTro6/Bed/panTro6.nogap.minLength20000.bed

foreach cLine (`cat $panTro6NoGap | tr '\t' '.'`)
	sbatch --wrap="./runAxtSwapandSplit.csh $cLine"
end

echo DONE
		
