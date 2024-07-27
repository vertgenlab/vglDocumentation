#!/bin/csh -ef

set noGap = /hpc/group/vertgenlab/RefGenomes/hg38/Bed/hg38.nogap.bed
set roadmap = /hpc/group/vertgenlab/publicDataSets/RoadmapEpigenomics/15stateChromHmm/ByState
set state = $1

mkdir -p output
mkdir -p output/shared

foreach epigenome ($roadmap/$state/*.bed)
	set epi = $epigenome:t:r
	~/go/bin/overlapEnrichments -trimToRefGenome normalApproximate $epigenome shared.hg38.showGapped.bed $noGap output/shared/$state.$epi.txt
end

echo DONE
