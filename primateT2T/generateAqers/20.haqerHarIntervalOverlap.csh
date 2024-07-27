#!/bin/csh -ef

set intervalOverlap = ~/go/bin/intervalOverlap
set tmp = /work/yl726/PrimateT2T_15way
set haqerDir = /work/yl726/PrimateT2T_15way/haqerTmpb/*.trimmed.T2T.bed
set harInFile = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_10way/har.hs1.bed

mkdir -p $tmp/haqerHarIntervalOverlap

foreach haqerSelectFile (`ls -1 $haqerDir`)
        set haqerBase = `basename $haqerSelectFile`
        set haqerNAME = $haqerBase:r:r
        echo "Working on" $haqerNAME
        $intervalOverlap -threads 8 $haqerSelectFile $harInFile $tmp/haqerHarIntervalOverlap/har.$haqerNAME.overlap.bed
end

echo DONE
