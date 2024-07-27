#!/bin/csh -evf

set windowSize = $1

set targetT2T = "humanT2T"
set fdrThreshold = 6.5
set fdrField = 3

set tmp = /work/yl726/PrimateT2T_15way
set bedFormat = ~/go/bin/bedFormat
set bedFilter = ~/go/bin/bedFilter
set bedMerge = ~/go/bin/bedMerge
set bedToWig = ~/go/bin/bedToWig
#set mergeSort = ~/go/bin/mergesort
set mergeSort = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/mergesort/mergesort
set wigToBigWig = /hpc/group/vertgenlab/cl454/bin/x86_64/wigToBigWig
set bedToBigBed = /hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed

echo $windowSize

# T2T

# prep for peak calling
#cat $tmp/haqerTmpb/*.$windowSize.diff.T2T.bed.gz > $tmp/haqerTmpb/$windowSize.merged.diff.T2T.bed.gz
#rm $tmp/haqerTmpb/*.$windowSize.diff.T2T.bed.gz
#$bedFormat -fdrAnnotation -rawPValueAnnotationField 1 $tmp/haqerTmpb/$windowSize.merged.diff.T2T.bed.gz $tmp/haqerTmpb/merged.$windowSize.diff.fdr.T2T.bed.gz
#rm $tmp/haqerTmpb/$windowSize.merged.diff.T2T.bed.gz

# peak calling
mkdir -p /work/yl726/tmp.$windowSize
$bedFilter -minAnnotationFloat $fdrThreshold -annotationFilterField $fdrField $tmp/haqerTmpb/merged.$windowSize.diff.fdr.T2T.bed.gz $tmp/haqerTmpb/merged.$windowSize.diff.fdr.T2T.filtered.bed.gz
$mergeSort -tmpDir=/work/yl726/tmp.$windowSize $tmp/haqerTmpb/merged.$windowSize.diff.fdr.T2T.filtered.bed.gz stdout | $bedMerge -lowMem -mergeAdjacent stdin $tmp/haqerTmpb/haqer.$windowSize.T2T.bed

# from peak calling to trimmed
cat $tmp/haqerTmpb/haqer.$windowSize.T2T.bed | cut -f1-4 > $tmp/haqerTmpb/haqer.$windowSize.trimmed.T2T.bed 

# big bed
$bedToBigBed $tmp/haqerTmpb/haqer.$windowSize.trimmed.T2T.bed $tmp/$targetT2T.chrom.sizes $tmp/haqerTmpb/haqer.$windowSize.T2T.bb

# wigs
$bedToWig -annotationField 1 -missingData 0 Annotation $tmp/haqerTmpb/merged.$windowSize.diff.fdr.T2T.bed.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.fdr.T2T.wig.gz
$wigToBigWig $tmp/wig/$windowSize.fdr.T2T.wig.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.fdr.T2T.bw
$bedToWig -annotationField 0 -missingData 0 Annotation $tmp/haqerTmpb/merged.$windowSize.diff.fdr.T2T.bed.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.div.T2T.wig.gz
$wigToBigWig $tmp/wig/$windowSize.div.T2T.wig.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.div.T2T.bw
#rm $tmp/wig/$windowSize.*.T2T.wig.gz

echo DONE
