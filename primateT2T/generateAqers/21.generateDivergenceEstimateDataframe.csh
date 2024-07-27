#!/bin/csh -evf

set bedSplit = ~/go/bin/bedSplit

set T2TFileDir=/work/yl726/PrimateT2T_15way/haqerTmpb
set GappedFileDir=/work/yl726/PrimateT2T_15way/haqerTmp
set JoinedDir=/work/yl726/PrimateT2T_15way/divergenceComp
set JoinedDirByChrom = /work/yl726/PrimateT2T_15way/divergenceComp/byChrom
mkdir -p $JoinedDir
mkdir -p $JoinedDirByChrom

set T2TOriginal=$T2TFileDir/merged.500.diff.fdr.T2T.bed.gz
set GappedOriginal=$GappedFileDir/500.merged.diff.Gapped.bed.gz
set chromList = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/chroms.list

#gunzip $T2TOriginal
#gunzip $GappedOriginal

#sort -k 4,4 -f $T2TFileDir/merged.500.diff.fdr.T2T.bed > $T2TFileDir/merged.500.diff.fdr.T2T.sorted.bed
#sort -k 4,4 -f $GappedFileDir/500.merged.diff.Gapped.bed > $GappedFileDir/500.merged.diff.Gapped.sorted.bed

#$bedSplit byChrom $T2TFileDir/merged.500.diff.fdr.T2T.sorted.bed $T2TFileDir/T2TDiffByChrom
#$bedSplit byChrom $GappedFileDir/500.merged.diff.Gapped.sorted.bed $GappedFileDir/GappedDiffByChrom

#foreach c (`cat $chromList`)
#    echo $c
#    sbatch --mem=40G --mail-type=END,FAIL --mail-user=yanting.luo@duke.edu --wrap="join -i -j4 $GappedFileDir/GappedDiffByChrom/$c.bed $T2TFileDir/T2TDiffByChrom/$c.bed -a 1 -a 2 -e '-1' -o '1.4,1.3,1.5,1.9,2.4,2.3,2.5,2.9' > $JoinedDirByChrom/$c.bed"
#end
# notes: join by field 4 (e.g. chr10_3741), output "1.4=chr_start 1.3=GappedEnd 1.5=GappedDivergenceCount 1.9=GappedStartAlnPos 2.4=chr_start 2.3=T2TEnd 2.5=T2TDivergenceCount 2.9=T2TStartAlnPos". -e means will output no-match empty fields as well. Manual: https://linux.die.net/man/1/join

# run the below after join all finish

cat $JoinedDirByChrom/*.bed > $JoinedDir/allChr.bed

set lineNum = (`wc -l < $JoinedDir/allChr.bed`)
echo $lineNum
set lineNumFrac = (`expr $lineNum / 100`)
echo $lineNumFrac
shuf -n $lineNumFrac $JoinedDir/allChr.bed > $JoinedDir/allChr.sample.bed

echo DONE
