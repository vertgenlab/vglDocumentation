#!/bin/csh -evf

set faFilter = ~/go/bin/faFilter
set reconstructSeq = ~/go/bin/reconstructSeq
#set faFindFast = ~/go/bin/faFindFast
# temporarily change faFindFast path to below line, while working on gonomics non-main branch
set faFindFast = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/faFindFast/faFindFast
set bedMerge = ~/go/bin/bedMerge

set targetT2T = "humanT2T"
set reconT2T = "hcaT2T"
set nonBiasBaseThreshold = 0.8
set chr = "$1"

set tmp = /work/yl726/PrimateT2T_15way
set haqerTmp = $tmp/haqerTmpb
mkdir -p $haqerTmp
set outDir = $tmp/fastest10mbWindowsb
mkdir -p $outDir

echo $chr

# execute reconstructSeq
$reconstructSeq -nonBiasBaseThreshold=$nonBiasBaseThreshold -biasLeafName=$targetT2T -keepAllSeq allT2T.4d.mod $tmp/rawFab/$chr.fa $haqerTmp/$chr.hcaT2T.mleRecon.fa.gz
echo "reconstructSeq hcaT2T done"

# fastestNeutralRate
sbatch --mem=10G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="$faFindFast -chrom $chr -windowSize 10_000_000 -firstQueryName humanT2T -secondQueryName hcaT2T -longOutput -outputAlnPos $haqerTmp/$chr.hcaT2T.mleRecon.fa.gz $haqerTmp/$chr.mleRecon.10mbDiff.T2T.bed.gz;zcat $haqerTmp/$chr.mleRecon.10mbDiff.T2T.bed.gz | $bedMerge -lowMem -mergeAdjacent stdin $outDir/$chr.T2T.HighestScore.txt"

echo DONE
