#!/bin/csh -evf

set d = $1
set r = $2

set noGapFile = /hpc/group/vertgenlab/RefGenomes/hg38/Bed/hg38.nogap.minLength1000000.bed
set tmp = /work/yl726/PrimateT2T_15way/frozenGwasEnrichments
set overlapEnrichments = ~/go/bin/overlapEnrichments

set rFile = `basename $r`
set rPrefix = $rFile:r

set state = $d:t

set bedFiles = `ls $d`

set noglob # to prevent expanding further special characters like ? in filename

foreach b ($bedFiles)
        set bFile = `basename $b`
        set bPrefix = $bFile:r
        $overlapEnrichments -trimToRefGenome normalApproximate /hpc/group/vertgenlab/raven/raven/GWAS/gwasTraits/$b $r $noGapFile $tmp/$bPrefix.$state.$rPrefix.enrichment.txt
# for some reason, $b only calls the basename not full path. Since gwas only has 1 dir, I will manually expand full path
end

echo DONE
