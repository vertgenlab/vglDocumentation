#!/bin/csh -evf

set tmp = /work/yl726/PrimateT2T_15way
set mafToMultiFa = ~/go/bin/mafToMultiFa

set target = humanT2T

mkdir -p $tmp/rawFa

foreach m (/hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/multizMaf/*.maf)
	echo $m
	set mFile = `basename $m`
	echo $mFile
	set prefix = $mFile:r
	echo $prefix
	sbatch -J $prefix --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --mem=32G --wrap="$mafToMultiFa -noMask $m $tmp/$target.byChrom/$prefix.fa species.list $tmp/rawFa/$prefix.fa"
end

echo DONE
