#!/bin/csh -evf

set d = $1
set r = $2
set noGapFile = /hpc/group/vertgenlab/RefGenomes/hg38/Bed/hg38.nogap.minLength1000000.bed
set tmp = /work/yl726/PrimateT2T_15way/frozenChromhmmEnrichments
set overlapEnrichments = ~/go/bin/overlapEnrichments

set rFile = `basename $r`
set rPrefix = $rFile:r

set state = $d:t

foreach b ($d/*.bed)
        set bFile = `basename $b`
        set bPrefix = $bFile:r
        $overlapEnrichments -trimToRefGenome normalApproximate $b $r $noGapFile $tmp/$bPrefix.$state.$rPrefix.enrichment.txt
end

cat $tmp/*.$state.$rPrefix.enrichment.txt > $tmp/$state.$rPrefix.merged.txt
rm $tmp/*.$state.$rPrefix.enrichment.txt

echo DONE
