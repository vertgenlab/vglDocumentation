#!/bin/csh -ef

mkdir -p ../reconAln

foreach file (*.fa)
	echo $file
	set prefix=$file:r
	sbatch --mem=150G --wrap="/home/rjm60/go/bin/quickPrimateRecon $file ../reconAln/$prefix.HCAaln.fa"
end

echo DONE
