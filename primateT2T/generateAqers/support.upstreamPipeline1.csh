#!/bin/csh -evf

set faFindFast = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/faFindFast/faFindFast
#set reconstructSeq = ~/go/bin/reconstructSeq
set reconstructSeq = /hpc/group/vertgenlab/raven/GOPATH/src/github.com/vertgenlab/gonomics/cmd/reconstructSeq/reconstructSeq
set bedMerge = ~/go/bin/bedMerge
set bedFilter = ~/go/bin/bedFilter
set faFilter = ~/go/bin/faFilter
set multiFaToVcf = ~/go/bin/multiFaToVcf

set tmp = /work/yl726/PrimateT2T_15way
#set rawFaDir=$tmp/rawFab
set rawFaDir=/hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/multizFa
set mod=/hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/allT2T.4d.mod

set nonBiasBaseThreshold = 0.8

set chr = "$1"

#first we set up our tmp directories

mkdir -p $tmp/caqerPriTmp
set caqerPriTmpDir = $tmp/caqerPriTmp
mkdir -p caqersPri
set caqerPriOutDir = $tmp/caqerPriFastest10mbWindows
mkdir -p $caqerPriOutDir

mkdir -p $tmp/caqerAltTmp
set caqerAltTmpDir = $tmp/caqerAltTmp
mkdir -p caqersAlt
set caqerAltOutDir = $tmp/caqerAltFastest10mbWindows
mkdir -p $caqerAltOutDir

mkdir -p $tmp/baqerPriTmp
set baqerPriTmpDir = $tmp/baqerPriTmp
mkdir -p baqersPri
set baqerPriOutDir = $tmp/baqerPriFastest10mbWindows
mkdir -p $baqerPriOutDir

mkdir -p $tmp/baqerAltTmp
set baqerAltTmpDir = $tmp/baqerAltTmp
mkdir -p baqersAlt
set baqerAltOutDir = $tmp/baqerAltFastest10mbWindows
mkdir -p $baqerAltOutDir

mkdir -p $tmp/gaqerPriTmp
set gaqerPriTmpDir = $tmp/gaqerPriTmp
mkdir -p gaqersPri
set gaqerPriOutDir = $tmp/gaqerPriFastest10mbWindows
mkdir -p $gaqerPriOutDir

mkdir -p $tmp/gaqerAltTmp
set gaqerAltTmpDir = $tmp/gaqerAltTmp
mkdir -p gaqersAlt
set gaqerAltOutDir = $tmp/gaqerAltFastest10mbWindows
mkdir -p $gaqerAltOutDir

#now we generate pairwise alignments of the modern/ancestral species (block order: chimpPri/HCA, chimpAlt/HCA, bonoboPri/HCA, bonoboAlt/HCA, gorillaPri/HGA, gorillaAlt/HGA)

sbatch --mem=40G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J chimpT2Tpri_$chr --wrap="$reconstructSeq -nonBiasBaseThreshold=$nonBiasBaseThreshold -biasLeafName=chimpT2Tpri -biasNodeName=hcaT2T -keepAllSeq $mod $rawFaDir/$chr.fa $caqerPriTmpDir/$chr.mleRecon.fa.gz"

sbatch --mem=40G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J chimpT2Talt_$chr --wrap="$reconstructSeq -nonBiasBaseThreshold=$nonBiasBaseThreshold -biasLeafName=chimpT2Talt -biasNodeName=hcaT2T -keepAllSeq $mod $rawFaDir/$chr.fa $caqerAltTmpDir/$chr.mleRecon.fa.gz"

sbatch --mem=40G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J bonoboT2Tpri_$chr --wrap="$reconstructSeq -nonBiasBaseThreshold=$nonBiasBaseThreshold -biasLeafName=bonoboT2Tpri -biasNodeName=hcaT2T -keepAllSeq $mod $rawFaDir/$chr.fa $baqerPriTmpDir/$chr.mleRecon.fa.gz"

sbatch --mem=40G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J bonoboT2Talt_$chr --wrap="$reconstructSeq -nonBiasBaseThreshold=$nonBiasBaseThreshold -biasLeafName=bonoboT2Talt -biasNodeName=hcaT2T -keepAllSeq $mod $rawFaDir/$chr.fa $baqerAltTmpDir/$chr.mleRecon.fa.gz"

sbatch --mem=40G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J gorillaT2Tpri_$chr --wrap="$reconstructSeq -nonBiasBaseThreshold=$nonBiasBaseThreshold -biasLeafName=gorillaT2Tpri -biasNodeName=hgaT2T -keepAllSeq $mod $rawFaDir/$chr.fa $gaqerPriTmpDir/$chr.mleRecon.fa.gz"

sbatch --mem=40G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu -J gorillaT2Talt_$chr --wrap="$reconstructSeq -nonBiasBaseThreshold=$nonBiasBaseThreshold -biasLeafName=gorillaT2Talt -biasNodeName=hgaT2T -keepAllSeq $mod $rawFaDir/$chr.fa $gaqerAltTmpDir/$chr.mleRecon.fa.gz"

# generate pairwiseVcf, optional
# mkdir -p pairwiseVcf
# $multiFaToVcf $caqerTmpDir/$chr.mleRecon.fa.gz $chr pairwiseVcf/$chr.Pantro6.HCA.vcf.gz
# $multiFaToVcf $gaqerTmpDir/$chr.mleRecon.fa.gz $chr pairwiseVcf/$chr.gorGor5.HGA.vcf.gz

echo DONE
