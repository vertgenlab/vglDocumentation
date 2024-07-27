#!/bin/csh -evf

set tmp = /work/yl726/PrimateT2T_15way

foreach file (`ls -1 $tmp/rawFa/*.fa`)
	set chr = $file:t:r
	echo $chr
	#sbatch --mem=16G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="./support.faFindFast.T2T.csh $chr"
	sbatch --mem=16G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="./support.faFindFast.Gapped.csh $chr"
end

echo DONE
