#!/bin/csh -evf

set tmp = /work/yl726/PrimateT2T_15way
#set windowSizes = (500)
set windowSizes = (25 50 100 200 300 400 500 750 1000 2000 5000 10_000 20_000 50_000 100_000 200_000 500_000 1_000_000)

mkdir -p $tmp/wig

foreach windowSize ($windowSizes)
        echo $windowSize
	sbatch --mem=64G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="./support.findRegions.b.csh $windowSize"
end

echo DONE
