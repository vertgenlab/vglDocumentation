#!/bin/csh -ef

mkdir -p ../reconAln

foreach file (*.fa)
	echo $file
	set prefix=$file:r
	/home/rjm60/go/bin/quickPrimateRecon -messyToN $file ../reconAln/MessyToN/$prefix.HCAaln.fa
	#sbatch --mem=15G --wrap="/home/rjm60/go/bin/quickPrimateRecon -messyToN $file ../reconAln/MessyToN/$prefix.HCAaln.fa"
end

echo DONE
