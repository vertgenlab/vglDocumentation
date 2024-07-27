#!/bin/csh -evf

set faFindFast = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/faFindFast/faFindFast

set tmp = /work/yl726/PrimateT2T_15way

set chr = "$1"
set windowSize = 500
set caqerPriDivergenceRate = 0.0131431
set caqerAltDivergenceRate = 0.0131676
set baqerPriDivergenceRate = 0.0139144
set baqerAltDivergenceRate = 0.0133015
set gaqerPriDivergenceRate = 0.0137113
set gaqerAltDivergenceRate = 0.0136908

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

#faFindFast (block order: chimpPri/HCA, chimpAlt/HCA, bonoboPri/HCA, bonoboAlt/HCA, gorillaPri/HGA, gorillaAlt/HGA)
sbatch --mem=32G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J chimpT2Tpri_$chr --wrap="$faFindFast -longOutput -divergenceRate $caqerPriDivergenceRate -chrom $chr -windowSize $windowSize -firstQueryName chimpT2Tpri -secondQueryName hcaT2T -outputAlnPos $caqerPriTmpDir/$chr.mleRecon.fa.gz $caqerPriTmpDir/$chr.$windowSize.diff.T2T.bed.gz"

sbatch --mem=32G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J chimpT2Talt_$chr --wrap="$faFindFast -longOutput -divergenceRate $caqerAltDivergenceRate -chrom $chr -windowSize $windowSize -firstQueryName chimpT2Talt -secondQueryName hcaT2T -outputAlnPos $caqerAltTmpDir/$chr.mleRecon.fa.gz $caqerAltTmpDir/$chr.$windowSize.diff.T2T.bed.gz"

sbatch --mem=32G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J bonoboT2Tpri_$chr --wrap="$faFindFast -longOutput -divergenceRate $baqerPriDivergenceRate -chrom $chr -windowSize $windowSize -firstQueryName bonoboT2Tpri -secondQueryName hcaT2T -outputAlnPos $baqerPriTmpDir/$chr.mleRecon.fa.gz $baqerPriTmpDir/$chr.$windowSize.diff.T2T.bed.gz"

sbatch --mem=32G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J bonoboT2Talt_$chr --wrap="$faFindFast -longOutput -divergenceRate $baqerAltDivergenceRate -chrom $chr -windowSize $windowSize -firstQueryName bonoboT2Talt -secondQueryName hcaT2T -outputAlnPos $baqerAltTmpDir/$chr.mleRecon.fa.gz $baqerAltTmpDir/$chr.$windowSize.diff.T2T.bed.gz"

sbatch --mem=32G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J gorillaT2Tpri_$chr --wrap="$faFindFast -longOutput -divergenceRate $gaqerPriDivergenceRate -chrom $chr -windowSize $windowSize -firstQueryName gorillaT2Tpri -secondQueryName hgaT2T -outputAlnPos $gaqerPriTmpDir/$chr.mleRecon.fa.gz $gaqerPriTmpDir/$chr.$windowSize.diff.T2T.bed.gz"

sbatch --mem=32G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J gorillaT2Talt_$chr --wrap="$faFindFast -longOutput -divergenceRate $gaqerAltDivergenceRate -chrom $chr -windowSize $windowSize -firstQueryName gorillaT2Talt -secondQueryName hgaT2T -outputAlnPos $gaqerAltTmpDir/$chr.mleRecon.fa.gz $gaqerAltTmpDir/$chr.$windowSize.diff.T2T.bed.gz"

echo DONE
