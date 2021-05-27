#!/bin/csh -ef

set pairwiseDir = /data/lowelab/RefGenomes/panTro6/panTro6_chrom/alignments
set hg38NoGap = /data/lowelab/RefGenomes/hg38/Bed/hg38.nogap.minLength1000000.bed
#set panTro6NoGap = /data/lowelab/RefGenomes/panTro6/Bed/panTro6.nogap.bed
set hg38Size = /data/lowelab/RefGenomes/hg38/hg38.chrom.sizes
set panTro6Size = /data/lowelab/RefGenomes/panTro6/panTro6.chrom.sizes
set axtFilter = /data/lowelab/cl454/bin/x86_64/axtFilter
set humanGenome = /data/lowelab/RefGenomes/hg38/hg38.2bit
set chimpGenome = /data/lowelab/RefGenomes/panTro6/panTro6.2bit
set gapFile = /data/lowelab/riley/toCraig/gapCost420.txt
set scoreFile = /data/lowelab/riley/toCraig/q.light.mat
set minScore = 20000
set cLine = $1

set cName = $cLine:e
set cEnd = $cLine:r:e
set cStart = $cLine:r:r:e
set cChrom = $cLine:r:r:r
	
foreach hLine(`cat $hg38NoGap | tr '\t' '.' | grep -v 'fix' | grep -v 'chrUn' | grep -v 'alt' | grep -v 'random' | grep -v 'chrM'`)
	set hName = $hLine:e
	set hEnd = $hLine:r:e
	set hStart = $hLine:r:r:e
	set hChrom = $hLine:r:r:r

	echo Working on Human: $hName Chimp: $cName

	mkdir -p $hChrom/chainingOutput/$cChrom

	$axtFilter $pairwiseDir/$hChrom/$cChrom.$hChrom.axt -tStartMin=$cStart -tEndMax=$cEnd \
	| axtSwap /dev/stdin $panTro6Size $hg38Size /dev/stdout \
	| $axtFilter /dev/stdin -tStartMin=$hStart -tEndMax=$hEnd \
	| axtChain -linearGap=$gapFile -scoreScheme=$scoreFile /dev/stdin $humanGenome $chimpGenome /dev/stdout \
	| chainSort /dev/stdin /dev/stdout \
	| chainFilter -minScore=$minScore /dev/stdin \
	| chainAntiRepeat  -minScore=$minScore $humanGenome $chimpGenome /dev/stdin $hChrom/chainingOutput/$cChrom/$hName.$cName.chain
end

echo DONE
		
