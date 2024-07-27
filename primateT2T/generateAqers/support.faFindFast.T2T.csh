#!/bin/csh -evf

set target = "humanT2T"
set chr = "$1"
#set windowSizes = (100 200 300 400 500 750 1000 2000 5000 10_000 20_000 50_000) #V1
#set windowSizes = (25 50 100_000 200_000 500_000 1_000_000) #V2
set windowSizes = (500) #V3
set divergenceRate = 0.0134763 #use the output of the script 14.fastestNeutralRate.csh
set tmp = /work/yl726/PrimateT2T_15way
mkdir -p $tmp/haqerTmp
mkdir -p $tmp/haqers

#set faFindFast = ~/go/bin/faFindFast
# temporarily change faFindFast path to below line, while working on gonomics non-main branch
set faFindFast = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/faFindFast/faFindFast

foreach windowSize ($windowSizes)
        $faFindFast -longOutput -divergenceRate $divergenceRate -chrom $chr -windowSize $windowSize -firstQueryName humanT2T -secondQueryName hcaT2T -outputAlnPos $tmp/haqerTmp/$chr.hcaT2T.mleRecon.fa.gz $tmp/haqerTmp/$chr.$windowSize.diff.T2T.bed.gz
end

echo DONE
