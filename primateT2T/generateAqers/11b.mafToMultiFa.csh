#!/bin/csh -evf

set tmp = /work/yl726/PrimateT2T_15way
set mafToMultiFa = ~/go/bin/mafToMultiFa

set target = humanT2T

mkdir -p $tmp/rawFab

foreach m ($tmp/outputb/*.maf)
	echo $m
	set mFile = `basename $m`
	echo $mFile
	set prefix = $mFile:r
	echo $prefix
	sbatch --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --mem=32G --wrap="$mafToMultiFa -noMask $m $tmp/$target.byChrom/$prefix.fa species.b.list $tmp/rawFab/$prefix.fa"
end

echo DONE
