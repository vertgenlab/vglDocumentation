#!/bin/csh -evf

set faFilter = ~/go/bin/faFilter
# temporarily change reconstructSeq path to below line, while working on gonomics non-main branch
#set reconstructSeq = ~/go/bin/reconstructSeq
set reconstructSeq = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/reconstructSeq/reconstructSeq
#set faFindFast = ~/go/bin/faFindFast
# temporarily change faFindFast path to below line, while working on gonomics non-main branch
set faFindFast = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/faFindFast/faFindFast
set bedMerge = ~/go/bin/bedMerge

set targetT2T = "humanT2T"
set targetGapped = "humanGapped"
set reconT2T = "hcaT2T"
set reconGapped = "hcaGapped"
set nonBiasBaseThreshold = 0.8
set chr = "$1"

set tmp = /work/yl726/PrimateT2T_15way
set haqerTmp = $tmp/haqerTmp
mkdir -p $haqerTmp
set outDir = $tmp/fastest10mbWindows
mkdir -p $outDir

echo $chr

# execute reconstructSeq 2x to add hcaT2T and hcaGapped
#$reconstructSeq -nonBiasBaseThreshold=$nonBiasBaseThreshold -biasLeafName=$targetT2T -keepAllSeq allT2T.4d.mod $tmp/rawFa/$chr.fa $haqerTmp/$chr.hcaT2T.mleRecon.fa.gz
#echo "reconstructSeq hcaT2T done"
# since T2T-only ran hcaT2T already, add Gapped to mleRecon (containing hcaT2T)? Can't because that file only has T2T no Gapped, so can't reconstructSeq on Gapped
$reconstructSeq -nonBiasBaseThreshold=$nonBiasBaseThreshold -biasLeafName=$targetGapped -keepAllSeq allGapped.4d.mod $tmp/rawFa/$chr.fa $haqerTmp/$chr.hcaGapped.mleRecon.fa.gz
echo "reconstructSeq hcaGapped done"

# fastestNeutralRate
# already have for Gapped and T2Tnew

echo DONE
