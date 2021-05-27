#!/bin/csh -ef

mkdir -p ../chimpReconAln

foreach file (*.fa)
	echo $file
	set prefix=$file:r
	sbatch --mem=150G --wrap="/home/rjm60/go/bin/chimpAncestorRecon $file ../chimpReconAln/$prefix.ChimpBiasedHCAaln.fa"
end

echo DONE
