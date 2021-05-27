#!/bin/csh -ef

mkdir -p Merged

foreach file (*.bed)
	set prefix=$file:r
	/home/rjm60/go/bin/bedMerge $file Merged/$prefix.merge.bed
	end
echo DONE
