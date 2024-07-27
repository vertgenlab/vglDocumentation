#!/bin/csh -evf

set faFindFast = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/faFindFast/faFindFast
set reconstructSeq = ~/go/bin/reconstructSeq
set bedMerge = ~/go/bin/bedMerge
set bedFilter = ~/go/bin/bedFilter
set faFilter = ~/go/bin/faFilter
set multiFaToVcf = ~/go/bin/multiFaToVcf

set tmp = /work/yl726/PrimateT2T_15way
set rawFaDir=$tmp/rawFab
set mod=/hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/allT2T.4d.mod

set nonBiasBaseThreshold = 0.8

set chr = "$1"

#first we set up our tmp directories
set caqerPriTmpDir = $tmp/caqerPriTmp
set caqerPriOutDir = $tmp/caqerPriFastest10mbWindows
set caqerAltTmpDir = $tmp/caqerAltTmp
set caqerAltOutDir = $tmp/caqerAltFastest10mbWindows
set baqerPriTmpDir = $tmp/baqerPriTmp
set baqerPriOutDir = $tmp/baqerPriFastest10mbWindows
set baqerAltTmpDir = $tmp/baqerAltTmp
set baqerAltOutDir = $tmp/baqerAltFastest10mbWindows
set gaqerPriTmpDir = $tmp/gaqerPriTmp
set gaqerPriOutDir = $tmp/gaqerPriFastest10mbWindows
set gaqerAltTmpDir = $tmp/gaqerAltTmp
set gaqerAltOutDir = $tmp/gaqerAltFastest10mbWindows

#find fastestNeutralRate (block order: chimpPri/HCA, chimpAlt/HCA, bonoboPri/HCA, bonoboAlt/HCA, gorillaPri/HGA, gorillaAlt/HGA)
sbatch --mem=20G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J chimpT2Tpri_$chr --wrap="$faFindFast -chrom $chr -windowSize 10_000_000 -firstQueryName chimpT2Tpri -secondQueryName hcaT2T -longOutput -outputAlnPos $caqerPriTmpDir/$chr.mleRecon.fa.gz $caqerPriTmpDir/$chr.mleRecon.10mbDiff.bed.gz;zcat $caqerPriTmpDir/$chr.mleRecon.10mbDiff.bed.gz | $bedMerge -lowMem -mergeAdjacent stdin $caqerPriOutDir/$chr.T2T.HighestScore.txt"

sbatch --mem=20G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J chimpT2Talt_$chr --wrap="$faFindFast -chrom $chr -windowSize 10_000_000 -firstQueryName chimpT2Talt -secondQueryName hcaT2T -longOutput -outputAlnPos $caqerAltTmpDir/$chr.mleRecon.fa.gz $caqerAltTmpDir/$chr.mleRecon.10mbDiff.bed.gz;zcat $caqerAltTmpDir/$chr.mleRecon.10mbDiff.bed.gz | $bedMerge -lowMem -mergeAdjacent stdin $caqerAltOutDir/$chr.T2T.HighestScore.txt"

sbatch --mem=20G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J bonoboT2Tpri_$chr --wrap="$faFindFast -chrom $chr -windowSize 10_000_000 -firstQueryName bonoboT2Tpri -secondQueryName hcaT2T -longOutput -outputAlnPos $baqerPriTmpDir/$chr.mleRecon.fa.gz $baqerPriTmpDir/$chr.mleRecon.10mbDiff.bed.gz;zcat $baqerPriTmpDir/$chr.mleRecon.10mbDiff.bed.gz | $bedMerge -lowMem -mergeAdjacent stdin $baqerPriOutDir/$chr.T2T.HighestScore.txt"

sbatch --mem=20G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J bonoboT2Talt_$chr --wrap="$faFindFast -chrom $chr -windowSize 10_000_000 -firstQueryName bonoboT2Talt -secondQueryName hcaT2T -longOutput -outputAlnPos $baqerAltTmpDir/$chr.mleRecon.fa.gz $baqerAltTmpDir/$chr.mleRecon.10mbDiff.bed.gz;zcat $baqerAltTmpDir/$chr.mleRecon.10mbDiff.bed.gz | $bedMerge -lowMem -mergeAdjacent stdin $baqerAltOutDir/$chr.T2T.HighestScore.txt"

sbatch --mem=20G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J gorillaT2Tpri_$chr --wrap="$faFindFast -chrom $chr -windowSize 10_000_000 -firstQueryName gorillaT2Tpri -secondQueryName hgaT2T -longOutput -outputAlnPos $gaqerPriTmpDir/$chr.mleRecon.fa.gz $gaqerPriTmpDir/$chr.mleRecon.10mbDiff.bed.gz;zcat $gaqerPriTmpDir/$chr.mleRecon.10mbDiff.bed.gz | $bedMerge -lowMem -mergeAdjacent stdin $gaqerPriOutDir/$chr.T2T.HighestScore.txt"

sbatch --mem=20G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J gorillaT2Talt_$chr --wrap="$faFindFast -chrom $chr -windowSize 10_000_000 -firstQueryName gorillaT2Talt -secondQueryName hgaT2T -longOutput -outputAlnPos $gaqerAltTmpDir/$chr.mleRecon.fa.gz $gaqerAltTmpDir/$chr.mleRecon.10mbDiff.bed.gz;zcat $gaqerAltTmpDir/$chr.mleRecon.10mbDiff.bed.gz | $bedMerge -lowMem -mergeAdjacent stdin $gaqerAltOutDir/$chr.T2T.HighestScore.txt"

echo DONE
