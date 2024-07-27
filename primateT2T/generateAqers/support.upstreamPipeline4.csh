#!/bin/csh -evf

set caqerPri = $1 # this will be $aqer input like caqerPri, caqerAlt, etc.
set fdrThreshold = 6.5
set fdrField = 3
set windowSize = 500

set tmp = /work/yl726/PrimateT2T_15way
set caqerPriTmpDir = $tmp/{$caqerPri}Tmp

set bedFormat = ~/go/bin/bedFormat
set bedFilter = ~/go/bin/bedFilter
set bedMerge = ~/go/bin/bedMerge
set bedToWig = ~/go/bin/bedToWig
#set mergeSort = ~/go/bin/mergesort
set mergeSort = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/mergesort/mergesort
set wigToBigWig = /hpc/group/vertgenlab/cl454/bin/x86_64/wigToBigWig
set bedToBigBed = /hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed

# get all chr
# prep for peak calling
cat $caqerPriTmpDir/*.$windowSize.diff.T2T.bed.gz > $caqerPriTmpDir/$windowSize.merged.diff.T2T.bed.gz
rm $caqerPriTmpDir/*.$windowSize.diff.T2T.bed.gz
$bedFormat -fdrAnnotation -rawPValueAnnotationField 1 $caqerPriTmpDir/$windowSize.merged.diff.T2T.bed.gz $caqerPriTmpDir/merged.$windowSize.diff.fdr.T2T.bed.gz
rm $caqerPriTmpDir/$windowSize.merged.diff.T2T.bed.gz

# peak calling
#mkdir -p /work/yl726/tmp.$windowSize
$bedFilter -minAnnotationFloat $fdrThreshold -annotationFilterField $fdrField $caqerPriTmpDir/merged.$windowSize.diff.fdr.T2T.bed.gz $caqerPriTmpDir/merged.$windowSize.diff.fdr.T2T.filtered.bed.gz
#$mergeSort -tmpDir=/work/yl726/tmp.$windowSize $tmp/haqerTmpb/merged.$windowSize.diff.fdr.T2T.filtered.bed.gz stdout | $bedMerge -lowMem -mergeAdjacent stdin $tmp/haqerTmpb/haqer.$windowSize.T2T.bed
$mergeSort $caqerPriTmpDir/merged.$windowSize.diff.fdr.T2T.filtered.bed.gz stdout | $bedMerge -lowMem -mergeAdjacent stdin $caqerPriTmpDir/$caqerPri.$windowSize.T2T.bed

# from peak calling to trimmed
cat $caqerPriTmpDir/$caqerPri.$windowSize.T2T.bed | cut -f1-4 > $caqerPriTmpDir/$caqerPri.$windowSize.trimmed.T2T.bed 

#set targetT2T = "humanT2T"
# big bed (not doing for now)
#$bedToBigBed $tmp/haqerTmpb/haqer.$windowSize.trimmed.T2T.bed $tmp/$targetT2T.chrom.sizes $tmp/haqerTmpb/haqer.$windowSize.T2T.bb
# wigs (not doing for now)
#$bedToWig -annotationField 1 -missingData 0 Annotation $tmp/haqerTmpb/merged.$windowSize.diff.fdr.T2T.bed.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.fdr.T2T.wig.gz
#$wigToBigWig $tmp/wig/$windowSize.fdr.T2T.wig.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.fdr.T2T.bw
#$bedToWig -annotationField 0 -missingData 0 Annotation $tmp/haqerTmpb/merged.$windowSize.diff.fdr.T2T.bed.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.div.T2T.wig.gz
#$wigToBigWig $tmp/wig/$windowSize.div.T2T.wig.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.div.T2T.bw
##rm $tmp/wig/$windowSize.*.T2T.wig.gz

echo DONE
