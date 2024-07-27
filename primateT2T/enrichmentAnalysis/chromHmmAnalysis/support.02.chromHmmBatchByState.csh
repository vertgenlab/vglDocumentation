#!/bin/csh -ef

set state = $1
set regionDir = regions
set noGap = /hpc/group/vertgenlab/RefGenomes/hg38/Bed/hg38.nogap.bed
set roadmap = /hpc/group/vertgenlab/publicDataSets/RoadmapEpigenomics/15stateChromHmm/ByState
mkdir -p output
mkdir -p output/human
mkdir -p output/chimpanzee
mkdir -p output/gorilla
mkdir -p output/bonobo

foreach epigenome ($roadmap/$state/*.bed)
	set epi = $epigenome:t:r
	~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate $epigenome $regionDir/bonobo.bed $noGap output/bonobo/$state.$epi.txt
	~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate $epigenome $regionDir/chimpanzee.bed $noGap output/chimpanzee/$state.$epi.txt
	~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate $epigenome $regionDir/gorilla.bed $noGap output/gorilla/$state.$epi.txt
	~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate $epigenome $regionDir/human.bed $noGap output/human/$state.$epi.txt
end


echo DONE
