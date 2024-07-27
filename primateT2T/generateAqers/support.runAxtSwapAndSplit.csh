#!/bin/csh -ef

set qLine = $1
set q = $2

set tmp = /work/yl726/PrimateT2T_15way
set target = humanT2T
set pairwiseDir = $tmp/alignments/pairwise.$target.$q
set tNoGap = $tmp/Bed/$target.noGap.bed
set qNoGap = $tmp/Bed/$q.noGap.bed
set tSizes = $tmp/$target.chrom.sizes
set qSizes = $tmp/$q.chrom.sizes
set tGenome = $tmp/$target.2bit
set qGenome = $tmp/$q.2bit
set startingAxtPairwiseDir = /hpc/group/vertgenlab/publicDataSets/PrimateT2T_15way/lastzAxt/pairwise.$target.$q

set axtFilter = /hpc/group/vertgenlab/cl454/bin/unstable/axtFilter
set axtSwap = /hpc/group/vertgenlab/cl454/bin/x86_64/axtSwap
set axtChain = /hpc/group/vertgenlab/cl454/bin/x86_64/axtChain
set chainSort = /hpc/group/vertgenlab/cl454/bin/x86_64/chainSort
set chainFilter = /hpc/group/vertgenlab/cl454/bin/x86_64/chainFilter
set chainAntiRepeat = /hpc/group/vertgenlab/cl454/bin/x86_64/chainAntiRepeat
set scoreFile = /hpc/group/vertgenlab/alignmentSupportFiles/q.light.mat
set gapFile = /hpc/group/vertgenlab/alignmentSupportFiles/gapCost.txt
set minScore = 60000

set qName = $qLine:e
set qEnd = $qLine:r:e
set qStart = $qLine:r:r:e
set qChrom = $qLine:r:r:r

foreach tLine(`cat $tNoGap | tr '\t' '.'`) # for each ungapped region of the target genome
	set tName = $tLine:e
	set tEnd = $tLine:r:e
	set tStart = $tLine:r:r:e
	set tChrom = $tLine:r:r:r
	mkdir -p $pairwiseDir/$tChrom/chainingOutput
	mkdir -p $pairwiseDir/$tChrom/chainingOutput/$qChrom
	
	#$axtFilter $pairwiseDir/$tChrom/$qChrom.$tChrom.axt -tStartMin=$tStart -tEndMax=$tEnd \
	$axtFilter $startingAxtPairwiseDir/$tChrom/$qChrom.$tChrom.axt -tStartMin=$tStart -tEndMax=$tEnd \
	| $axtSwap stdin $tSizes $qSizes stdout \
	| $axtFilter stdin -tStartMin=$qStart -tEndMax=$qEnd \
	| $axtSwap stdin $qSizes $tSizes stdout \
	| $axtChain -linearGap=$gapFile -scoreScheme=$scoreFile stdin $tGenome $qGenome stdout \
	| $chainSort stdin stdout \
	| $chainFilter -minScore=$minScore stdin \
	| $chainAntiRepeat -minScore=$minScore $tGenome $qGenome stdin $pairwiseDir/$tChrom/chainingOutput/$qChrom/$tName.$qName.chain
end

echo DONE
