
set netChainSubset=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/netChainSubset
set axtToPsl=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/axtToPsl
set chainToPsl=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/chainToPslBasic
set pslToBed=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/pslToBed
set netToBed=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/netToBed
set axtChain=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/axtChain
set chainSort=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/chainSort
set chainPreNet=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/chainPreNet
set chainFilter=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/chainFilter
set chainNet=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/chainNet
set netSyntenic=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/netSyntenic
set netFilter=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/netFilter
set netClass=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/netClass
set netToBed=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/netToBed
set netToAxt=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/netToAxt
set axtToMaf=/hpc/group/vertgenlab/softwareShared/kent/kent.Jul.30.2021/axtToMaf
set multiz=/hpc/group/vertgenlab/softwareShared/multiz-tba.012109/multiz
set temp=/work/cf189/runPairwiseAlignments/temp/60way
set lowerLim=0.2
set upperLim=0.7

set refList="hg38"
set speciesList=/work/cf189/runPairwiseAlignments/species.list1


foreach ref (`cat $refList`)
set tSize=/work/cf189/runPairwiseAlignments/genomes/$ref/$ref.chrom.sizes
set tBit=/work/cf189/runPairwiseAlignments/genomes/$ref/$ref.2bit

echo $ref

foreach species (`cat $speciesList`)
set qSize=/work/cf189/runPairwiseAlignments/genomes/$species/$species.chrom.sizes
set qBit=/work/cf189/runPairwiseAlignments/genomes/$species/$species.2bit

echo $species

if (`echo $species` == `echo $ref`) then
continue
endif

foreach dist (`cat /work/cf189/runPairwiseAlignments/60wayTree.dists.comma.txt`)
set word=($dist:as/,/ /)

if ($word[1] != "(total)") then

if (`echo $ref` == `echo $species`) then
set matrix="none"

else if (`echo $species` == `echo $word[1]` && `echo $ref` == `echo $word[2]`) then
set outDir=/work/cf189/runPairwiseAlignments/chainingNetting/$ref.$species

set actual=$word[3]

echo $actual

set resultClose=`awk -v lowerLim="$lowerLim" -v upperLim="$upperLim" -v actual="$actual" 'BEGIN { if (actual <= lowerLim) print "true"; else print "false" }'`
set resultDefault=`awk -v lowerLim="$lowerLim" -v upperLim="$upperLim" -v actual="$actual" 'BEGIN { if (actual >= lowerLim && actual <= upperLim) print "true"; else print "false" }'`
echo $resultClose
echo $resultDefault

if ($resultClose == "true") then
set matrix=/hpc/group/vertgenlab/alignmentSupportFiles/human_chimp_v2.mat
else if ($resultDefault == "true") then
set matrix=/hpc/group/vertgenlab/alignmentSupportFiles/default.mat
else
set matrix=/hpc/group/vertgenlab/alignmentSupportFiles/hoxD55.mat
endif

else if (`echo $species` == `echo $word[2]` && `echo $ref` == `echo $word[1]`) then
set outDir=/work/cf189/runPairwiseAlignments/chainingNetting/$ref.$species

set actual=$word[3]

echo $actual

set resultClose=`awk -v lowerLim="$lowerLim" -v upperLim="$upperLim" -v actual="$actual" 'BEGIN { if (actual <= lowerLim) print "true"; else print "false" }'`
set resultDefault=`awk -v lowerLim="$lowerLim" -v upperLim="$upperLim" -v actual="$actual" 'BEGIN { if (actual >= lowerLim && actual <= upperLim) print "true"; else print "false" }'`
echo $resultClose
echo $resultDefault


if ($resultClose == "true") then
set matrix=/hpc/group/vertgenlab/alignmentSupportFiles/human_chimp_v2.mat
else if ($resultDefault == "true") then
set matrix=/hpc/group/vertgenlab/alignmentSupportFiles/default.mat
else
set matrix=/hpc/group/vertgenlab/alignmentSupportFiles/hoxD55.mat

endif

else
continue

endif

echo $matrix

if ($matrix:t == hoxD55.mat) then
set linearGap="loose"
set minSynScore=50000
set minChainScore=20000

foreach file (`find /work/cf189/runPairwiseAlignments/chainingNetting/$ref.$species -name "*.axt"`)
set name=$file:t:r
set tName=$file:t:r:r
set outChain=$temp/$name.filteredScore.chain
set syntenic=$temp/$name.unfilteredSyntenic.net
set outSynTarget=$outDir/$name.filteredSyn.net
set outPsl=$temp/$name.filteredNet.psl
set bed=$outDir/$name.syntenic.bed
set outAxt=$temp/$name.filteredNet.axt
set maf=/work/cf189/runPairwiseAlignments/mafs/$name.maf
set chain=$outDir/$name.syntenic.chain

$axtChain -linearGap=$linearGap -scoreScheme=$matrix $file $tBit $qBit stdout \
| $chainSort stdin stdout \
| $chainPreNet stdin $tSize $qSize stdout \
| $chainFilter -minScore=$minChainScore stdin > $outChain
$chainNet $outChain $tSize $qSize stdout /dev/null \
| $netSyntenic stdin stdout > $syntenic
$netFilter -syn -minSynScore=$minSynScore $syntenic > $outSynTarget
$netToBed -maxGap=0 $outSynTarget $bed
$netToAxt $outSynTarget $outChain $tBit $qBit $outAxt
$axtToPsl $outAxt $tSize $qSize $outPsl
$axtToMaf -tPrefix=$ref. -qPrefix=$species. $outAxt $tSize $qSize $maf
$netChainSubset $outSynTarget $outChain $chain

end

else if ($matrix:t == human_chimp_v2.mat) then
set linearGap="medium"
set minChainScore=1000000

foreach file (`find /work/cf189/runPairwiseAlignments/chainingNetting/$ref.$species -name "*.axt"`)
set name=$file:t:r
set tName=$file:t:r:r
set outChain=$temp/$name.filteredScore.chain
set syntenic=$temp/$name.unfilteredSyntenic.net
set outSynTarget=$outDir/$name.filteredSyn.net
set outPsl=$temp/$name.filteredNet.psl
set bed=$outDir/$name.syntenic.bed
set outAxt=$temp/$name.filteredNet.axt
set maf=/work/cf189/runPairwiseAlignments/mafs/$name.maf
set chain=$outDir/$name.syntenic.chain

$axtChain -linearGap=$linearGap -scoreScheme=$matrix $file $tBit $qBit stdout \
| $chainSort stdin stdout \
| $chainPreNet stdin $tSize $qSize stdout \
| $chainFilter -minScore=$minChainScore stdin > $outChain
$chainNet $outChain $tSize $qSize stdout /dev/null \
| $netSyntenic stdin stdout > $syntenic
$netFilter -chimpSyn $syntenic > $outSynTarget
$netToBed -maxGap=0 $outSynTarget $bed
$netToAxt $outSynTarget $outChain $tBit $qBit $outAxt
$axtToPsl $outAxt $tSize $qSize $outPsl
$axtToMaf -tPrefix=$ref. -qPrefix=$species. $outAxt $tSize $qSize $maf
$netChainSubset $outSynTarget $outChain $chain

end

else if ($matrix:t == default.mat) then
set linearGap="medium"
set minChainScore=100000
foreach file (`find /work/cf189/runPairwiseAlignments/chainingNetting/$ref.$species -name "*.axt"`)
set name=$file:t:r
set tName=$file:t:r:r
set outChain=$temp/$name.filteredScore.chain
set syntenic=$temp/$name.unfilteredSyntenic.net
set outSynTarget=$outDir/$name.filteredSyn.net
set outPsl=$temp/$name.filteredNet.psl
set bed=$outDir/$name.syntenic.bed
set outAxt=$temp/$name.filteredNet.axt
set maf=/work/cf189/runPairwiseAlignments/mafs/$name.maf
set chain=$outDir/$name.syntenic.chain

$axtChain -linearGap=$linearGap -scoreScheme=$matrix $file $tBit $qBit stdout \
| $chainSort stdin stdout \
| $chainPreNet stdin $tSize $qSize stdout \
| $chainFilter -minScore=$minChainScore stdin > $outChain
$chainNet $outChain $tSize $qSize stdout /dev/null \
| $netSyntenic stdin stdout > $syntenic
$netFilter -syn $syntenic > $outSynTarget
$netToBed -maxGap=0 $outSynTarget $bed
$netToAxt $outSynTarget $outChain $tBit $qBit $outAxt
$axtToPsl $outAxt $tSize $qSize $outPsl
$axtToMaf -tPrefix=$ref. -qPrefix=$species. $outAxt $tSize $qSize $maf
$netChainSubset $outSynTarget $outChain $chain

end

else
continue
endif
endif
end
end
end
echo "DONE"

