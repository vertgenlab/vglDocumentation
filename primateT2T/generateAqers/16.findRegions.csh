#!/bin/csh -evf

set tmp = /work/yl726/PrimateT2T_15way
#set windowSizes = (100 200 300 400 500 750 1000 2000 5000 10_000 20_000 50_000) # V1
set windowSizes = (500) # V3

mkdir -p $tmp/wig

foreach windowSize ($windowSizes)
	sbatch --mem=64G --wrap="./support.findRegions.csh $windowSize"
end

echo DONE
