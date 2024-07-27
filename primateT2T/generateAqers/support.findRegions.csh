#!/bin/csh -evf

set windowSize = $1

set targetT2T = "humanT2T"
set targetGapped = "humanGapped"
set fdrThreshold = 6.5
set fdrField = 2

set tmp = /work/yl726/PrimateT2T_15way
set bedFormat = ~/go/bin/bedFormat
set bedFilter = ~/go/bin/bedFilter
set bedMerge = ~/go/bin/bedMerge
set bedToWig = ~/go/bin/bedToWig
set wigToBigWig = /hpc/group/vertgenlab/cl454/bin/x86_64/wigToBigWig
set bedToBigBed = /hpc/group/vertgenlab/cl454/bin/x86_64/bedToBigBed

# T2T

#cat $tmp/haqerTmp/*.$windowSize.diff.T2T.bed.gz > $tmp/haqerTmp/$windowSize.merged.diff.T2T.bed.gz
#rm $tmp/haqerTmp/*.$windowSize.diff.T2T.bed.gz
#$bedFormat -fdrAnnotation -rawPValueAnnotationField 1 $tmp/haqerTmp/$windowSize.merged.diff.T2T.bed.gz $tmp/haqerTmp/merged.$windowSize.diff.fdr.T2T.bed.gz
#rm $tmp/haqerTmp/$windowSize.merged.diff.T2T.bed.gz
#peak calling
#$bedFilter -minAnnotationFloat $fdrThreshold -annotationFilterField $fdrField $tmp/haqerTmp/merged.$windowSize.diff.fdr.T2T.bed.gz stdout | ~/go/bin/bedMerge -mergeAdjacent stdin $tmp/haqerTmp/haqer.$windowSize.T2T.bed

#cat $tmp/haqerTmp/haqer.$windowSize.T2T.bed | cut -f1-4 > $tmp/haqerTmp/haqer.$windowSize.trimmed.T2T.bed 
#$bedToBigBed $tmp/haqerTmp/haqer.$windowSize.trimmed.T2T.bed $tmp/$targetT2T.chrom.sizes $tmp/haqerTmp/haqer.$windowSize.T2T.bb

#wigs
#$bedToWig -annotationField 2 -missingData 0 Annotation $tmp/haqerTmp/merged.$windowSize.diff.fdr.T2T.bed.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.fdr.T2T.wig.gz
#$wigToBigWig $tmp/wig/$windowSize.fdr.T2T.wig.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.fdr.T2T.bw
#$bedToWig -annotationField 0 -missingData 0 Annotation $tmp/haqerTmp/merged.$windowSize.diff.fdr.T2T.bed.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.div.T2T.wig.gz
#$wigToBigWig $tmp/wig/$windowSize.div.T2T.wig.gz $tmp/$targetT2T.chrom.sizes $tmp/wig/$windowSize.div.T2T.bw
#rm $tmp/wig/$windowSize.*.T2T.wig.gz

# Gapped

cat $tmp/haqerTmp/*.$windowSize.diff.Gapped.bed.gz > $tmp/haqerTmp/$windowSize.merged.diff.Gapped.bed.gz
rm $tmp/haqerTmp/*.$windowSize.diff.Gapped.bed.gz
#$bedFormat -fdrAnnotation -rawPValueAnnotationField 1 $tmp/haqerTmp/$windowSize.merged.diff.Gapped.bed.gz $tmp/haqerTmp/merged.$windowSize.diff.fdr.Gapped.bed.gz
#rm $tmp/haqerTmp/$windowSize.merged.diff.Gapped.bed.gz
#peak calling
#$bedFilter -minAnnotationFloat $fdrThreshold -annotationFilterField $fdrField $tmp/haqerTmp/merged.$windowSize.diff.fdr.Gapped.bed.gz stdout | ~/go/bin/bedMerge -mergeAdjacent stdin $tmp/haqerTmp/haqer.$windowSize.Gapped.bed

#cat $tmp/haqerTmp/haqer.$windowSize.Gapped.bed | cut -f1-4 > $tmp/haqerTmp/haqer.$windowSize.trimmed.Gapped.bed 
#$bedToBigBed $tmp/haqerTmp/haqer.$windowSize.trimmed.Gapped.bed $tmp/$targetGapped.chrom.sizes $tmp/haqerTmp/haqer.$windowSize.Gapped.bb

#wigs
#$bedToWig -annotationField 2 -missingData 0 Annotation $tmp/haqerTmp/merged.$windowSize.diff.fdr.Gapped.bed.gz $tmp/$targetGapped.chrom.sizes $tmp/wig/$windowSize.fdr.Gapped.wig.gz
#$wigToBigWig $tmp/wig/$windowSize.fdr.Gapped.wig.gz $tmp/$targetGapped.chrom.sizes $tmp/wig/$windowSize.fdr.Gapped.bw
#$bedToWig -annotationField 0 -missingData 0 Annotation $tmp/haqerTmp/merged.$windowSize.diff.fdr.Gapped.bed.gz $tmp/$targetGapped.chrom.sizes $tmp/wig/$windowSize.div.Gapped.wig.gz
#$wigToBigWig $tmp/wig/$windowSize.div.Gapped.wig.gz $tmp/$targetGapped.chrom.sizes $tmp/wig/$windowSize.div.Gapped.bw
#rm $tmp/wig/$windowSize.*.Gapped.wig.gz

echo DONE
